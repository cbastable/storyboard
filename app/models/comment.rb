class Comment < ActiveRecord::Base
  attr_accessible :content, :rating
  belongs_to :user
  belongs_to :story
  
  validates :user_id, presence: true
  validates :story_id, presence: true
  validates :content, presence: true, length: {maximum: 500, minimum: 3}
  
  default_scope order: 'comments.created_at DESC'
end
