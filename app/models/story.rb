# == Schema Information
#
# Table name: stories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  blurb      :string(255)
#  genre      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Story < ActiveRecord::Base
  attr_accessible :blurb, :content, :genre, :title
  belongs_to :user
  has_many :stats, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # validate for max/min lengths too
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100, minimum: 3}
  validates :genre, presence: true
  validates :blurb, presence: true, length: {maximum: 250, minimum: 10}
  validates :content, presence: true, length: {
                      maximum: 10000,
                      
                      tokenizer: lambda {|str| str.scan(/\s+|$/)} }
  # minimum: 500, removed for db population
  
  def add_to_stats!(stat)
    stats.create!(viewer_id: stat.viewer_id, viewed: true)
  end
  
  def comment!(comment)
    comments.create!(user_id: comment.user_id, content: comment.content)
  end
  
  def uncomment!(comment)
    comments.find_by_id(comment.id).destroy
  end
  
  
  default_scope order: 'stories.created_at DESC'
  
end
