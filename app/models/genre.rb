# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Genre < ActiveRecord::Base
  attr_accessible :name
  
  has_many :primary_stories,    foreign_key: "primary_genre_id", class_name: "Story"
  has_many :secondary_stories,  foreign_key: "secondary_genre_id", class_name: "Story"
  has_many :tertiary_stories,   foreign_key: "tertiary_genre_id", class_name: "Story"
  
  validates :name, presence: true, length: {maximum: 50, minimum: 2}
end
