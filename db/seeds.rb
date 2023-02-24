# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Deleting exising movies'
Movie.destroy_all

puts 'Fetching movies from API and filling DB)'
url = 'https://tmdb.lewagon.com/movie/top_rated'
serialized_movies = URI.open(url).read
movies = JSON.parse(serialized_movies)
movies['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w200/#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

puts "Created #{Movie.count} movies!"
