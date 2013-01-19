# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  story_id   :integer
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :rating, :story_id, :user_id
  belongs_to :user
  belongs_to :story
  
  validates :user_id, presence: true
  validates :story_id, presence: true
  validates :content, presence: true, length: {maximum: 255, minimum: 3}
  
  default_scope order: 'comments.created_at DESC'
end
