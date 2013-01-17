namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_stories
   
  end
end

def make_users
  admin = User.create!(name:     "Conrad",
                       email:    "therightstuff17@gmail.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@storyboard.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_stories
  users = User.all(limit: 6)
  50.times do
    content = Faker::paragraph(3)
    users.each { |user| user.microposts.create!(content: content) }
  end
end