namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
    make_genres
    make_stories
    make_comments
    
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "admin@example.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  400.times do |n|
    name  = Faker::Name.first_name
    email = "example-#{n+1}@example.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_relationships
  users = User.all
  user  = users.first
  publishers = users[2..100]
  subscribers      = users[10..350]
  publishers.each { |publisher| user.subscribe!(publisher) }
  subscribers.each      { |subscriber| subscriber.subscribe!(user) }
end

def make_genres
  Genre.create!(name: "Fiction")
  Genre.create!(name: "Romance")
  Genre.create!(name: "Fantasy")
  Genre.create!(name: "Mystery")
  Genre.create!(name: "Sci Fi")
  Genre.create!(name: "Horror")
  Genre.create!(name: "Crime")
  Genre.create!(name: "Paranormal")
  Genre.create!(name: "Urban Fantasy")
  Genre.create!(name: "Thriller")
  Genre.create!(name: "Teen")
  Genre.create!(name: "Western")
  Genre.create!(name: "Fan Fiction")
end

def make_stories
  users = User.all(limit: 10)
    50.times do
      title = Faker::Lorem.sentence(1)
      genre = Genre.find((rand(12)+1))
      blurb = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(250)
      users.each { |user| user.stories.create!( title: title,
                                                primary_genre_id: genre.id,
                                                blurb: blurb,
                                                content: content) }
                                                
    end
end

def make_comments
  users = User.all(limit:50)
  stories = Story.all
  content = Faker::Lorem.sentence(10)
  users.each { |user|
    stories.each { |story|
      story.comments.create!(user_id: user.id, content: content)
    }
  }
end