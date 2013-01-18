# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  viewer_id  :integer
#  viewed     :boolean          default(FALSE)
#  rating     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :integer
#

class Stat < ActiveRecord::Base
  attr_accessible :rating, :viewed, :viewer_id
  belongs_to :story
  
  validates :viewer_id, presence: true
  validates :story_id, presence: true
  
  
  default_scope order: 'stats.created_at DESC'
end

# enforce viewer_id unique!