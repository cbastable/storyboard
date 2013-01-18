# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :stories, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :relationships, foreign_key: "reader_id", dependent: :destroy
  has_many :publishers, through: :relationships, source: :publisher
  has_many :reverse_relationships,  foreign_key: "publisher_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
  has_many :readers, through: :reverse_relationships, source: :reader
  
  has_many :boards, dependent: :destroy
  has_many :library_stories, through: :boards, source: :library_story
  
  
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true, length: {maximum: 50, minimum: 2} 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false} 
  validates :password, presence: true, length: {minimum: 6} 
  validates :password_confirmation, presence: true
  
  def subscribed?(other_user)
    relationships.find_by_publisher_id(other_user.id)
  end
  
  def subscribe!(other_user)
    relationships.create!(publisher_id: other_user.id)
  end
  
  def unsubscribe!(other_user)
    relationships.find_by_publisher_id(other_user.id).destroy
  end
  
  def in_storyboard?(board_name, story)
    boards.where(name: board_name).where(story_id: story.id)
  end
  
  def add_to_storyboard!(board)
    boards.create!(name: board.name, story_id: board.story_id)
  end
  
  def remove_from_storyboard!(board)
    boards.where(name: board.name).where(story_id: board.story_id).destroy
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end


#state machine for admin?