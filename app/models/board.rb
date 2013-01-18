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
  
  validates :name, presence: true, length: {maximum: 50}
  validates :user_id, presence: true
  validates :story_id, presence: true 
end
