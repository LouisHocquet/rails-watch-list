# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'http://tmdb.lewagon.com/movie/popular'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

puts "<<< Cleaning >>>"
puts "<<< Adding movies >>>"

movies["results"].each do |movie|
  new_movie = Movie.new(
    title: movie["original_title"],
    overview: movie["overview"],
    rating: movie["vote_average"]
  )
  new_movie.save
end

puts "<<< #{Movie.count} movies added >>>"
