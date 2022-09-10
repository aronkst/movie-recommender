class Movie < ApplicationRecord
  validates :imdb, :title, :year, :summary, :score, :amount_of_votes, :metascore, :points, :genres,
            :recommended_movies, :url_cover, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :score, numericality: { only_float: true, in: 0..10 }
  validates :amount_of_votes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :metascore, numericality: { only_integer: true, in: 0..100 }
  validates :imdb, uniqueness: true

  has_one :state, class_name: "State", primary_key: :imdb, foreign_key: :imdb

  paginates_per 12

  def self.from_get_movie(get_movie)
    Movie.create!(imdb: get_movie.imdb, title: get_movie.title, year: get_movie.year, summary: get_movie.summary,
                  score: get_movie.score, amount_of_votes: get_movie.amount_of_votes, metascore: get_movie.metascore,
                  points: get_movie.points, url_cover: get_movie.url_cover, genres: get_movie.genres,
                  recommended_movies: get_movie.recommended_movies)
  end
end
