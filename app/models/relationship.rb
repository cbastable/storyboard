class Relationship < ActiveRecord::Base
  attr_accessible :publisher_id
  
  belongs_to :reader, class_name: "User"
  belongs_to :publisher, class_name: "User"
  
  validates :reader_id, presence: true
  validates :publisher_id, presence: true
end
