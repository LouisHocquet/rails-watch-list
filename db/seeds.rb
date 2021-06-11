# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

img_url = "https://image.tmdb.org/t/p/w500"
base_url = 'http://tmdb.lewagon.com/movie/popular?page='

puts "<<< Cleaning >>>"
Movie.destroy_all

puts "<<< Adding movies >>>"
total_pages = 100
current_page = 1
while current_page <= total_pages do
  url = "#{base_url}#{current_page}"
  movies_serialized = URI.open(url).read
  movies = JSON.parse(movies_serialized)
  puts "current page #{current_page}"

  movies["results"].each do |movie|
    poster_url = "#{img_url}#{movie["poster_path"]}" 
    new_movie = Movie.new(
      title: movie["original_title"],
      overview: movie["overview"],
      rating: movie["vote_average"],
      poster_url: poster_url
    )
    new_movie.save
  end
  current_page += 1
end

puts "<<< #{Movie.count} movies added >>>"
