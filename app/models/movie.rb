class Movie < ApplicationRecord
  def self.from_get_movie(get_movie)
    Movie.create!(imdb: get_movie.imdb, title: get_movie.title, year: get_movie.year, summary: get_movie.summary,
                  score: get_movie.score, amount_of_votes: get_movie.amount_of_votes, metascore: get_movie.metascore,
                  points: get_movie.points, url_cover: get_movie.url_cover, genres: get_movie.genres,
                  recommended_movies: get_movie.recommended_movies)
  end
end
