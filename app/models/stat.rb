# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :integer
#  rated      :boolean          default(FALSE)
#

class Stat < ActiveRecord::Base
  attr_accessible :rating, :viewed, :viewer_id, :story_id, :rated
  belongs_to :story
  belongs_to :viewer, class_name: "User"
  
  validates :viewer_id, presence: true
  validates :story_id, presence: true
  
  
  default_scope order: 'stats.created_at DESC'
end
