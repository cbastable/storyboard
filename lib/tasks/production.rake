namespace :db do
  desc "Fill database with sample data"
  task production: :environment do
    make_admin
    make_initial_genres
  end
end

def make_admin
  admin = User.create!(name:     "Example User",
                       email:    "admin@example.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  admin.toggle!(:admin)
end

def make_initial_genres
  Genre.create!(name: "Fiction")
  Genre.create!(name: "Romance")
  Genre.create!(name: "Fanfiction")
  Genre.create!(name: "Urban_fantasy")
  Genre.create!(name: "Science_fiction")
end