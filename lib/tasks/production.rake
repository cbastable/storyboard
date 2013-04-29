namespace :db do
  desc "Fill database with sample data"
  task production: :environment do
    make_initial_genres
  end
end

def make_initial_genres
  Genre.create!(name: "Fiction")
  Genre.create!(name: "Romance")
  Genre.create!(name: "Fantasy")
  Genre.create!(name: "Mystery")
  Genre.create!(name: "Science_fiction")
  Genre.create!(name: "Horror")
  Genre.create!(name: "Paranormal")
  Genre.create!(name: "Urban_fantasy")
  Genre.create!(name: "Young_adult")
  Genre.create!(name: "Fanfiction")
end