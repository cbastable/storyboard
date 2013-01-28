# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Board < ActiveRecord::Base
  attr_accessible :name, :story_id
  
  belongs_to :user
  belongs_to :library_story, class_name: "Story", foreign_key: "story_id"
  #wanted to do has_many, but that would require putting a foreign_key inside each story (infeasible), so went with this 
  #approach
  
  validates :name, presence: true, length: {maximum: 50}
  validates :user_id, presence: true
end
