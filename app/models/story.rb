# == Schema Information
#
# Table name: stories
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  title              :string(255)
#  blurb              :string(255)
#  content            :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_genre_id   :integer
#  secondary_genre_id :integer
#  tertiary_genre_id  :integer
#  price              :integer          default(0)
#  upvotes            :integer          default(0)
#

class Story < ActiveRecord::Base
  attr_accessible :title, :blurb, :content, :primary_genre_id, :secondary_genre_id, :tertiary_genre_id, :upvotes
  belongs_to :user
  belongs_to :primary_genre,    class_name: "Genre"
  belongs_to :secondary_genre,  class_name: "Genre"
  belongs_to :tertiary_genre,   class_name: "Genre"
  
  
  has_many :stats, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # validate for max/min lengths too
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100, minimum: 3}
  validates :blurb, presence: true, length: {maximum: 250, minimum: 10}
  validates :content, presence: true, length: {
                      maximum: 10000,
                      
                      tokenizer: lambda {|str| str.scan(/\s+|$/)} }
  validates :primary_genre, presence: true
  # minimum: 500, removed for db population
  
  define_index do
    indexes :title
    indexes :blurb
    indexes :content
    indexes user(:name), as: :author
    indexes primary_genre(:name), as: :genre_1,   sortable: true
    indexes secondary_genre(:name), as: :genre_2, sortable: true
    indexes tertiary_genre(:name), as: :genre_3, sortable: true
    
    set_property field_weights: {
      title: 30,
      blurb: 15,
      content: 1,
      author: 30,
      genre_1: 10, 
      genre_2: 7, 
      genre_3: 5,
      price: 1
    }  
      has user_id, created_at, updated_at
  end
  
  def add_to_stats!(stat)
    stats.create!(viewer_id: stat.viewer_id, viewed: true)
  end
  
  def comment!(comment)
    comments.create!(user_id: comment.user_id, content: comment.content)
  end
  
  def uncomment!(comment)
    comments.find_by_id(comment.id).destroy
  end
  
  def preview(story)
    story.content.split(" ").first(100).join(" ") + "..."
  end
  
  def viewcount(story)
    story.stats.select("DISTINCT viewer_id").count
  end
  
  def wordcount(story)
    story.content.scan(/[\w-]+/).size
  end
  
  def update_prices
    Story.all.each do |story|
      if story.viewcount(story) > 1000
        story.price = Math::log(story.viewcount.to_f).round.to_i
        story.save
      else
        story.price = 0
        story.save
      end
    end
  end
  
  default_scope order: 'stories.created_at DESC'
  
end
