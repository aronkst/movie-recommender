class State < ApplicationRecord
  VALID_VALUES = %w[like dislike watch_later block].freeze

  validates :imdb, :value, presence: true
  validates :value, inclusion: { in: VALID_VALUES }
  validates :imdb, uniqueness: true

  has_one :movie, class_name: 'Movie', primary_key: :imdb, foreign_key: :imdb

  def set_movie
    movie = valid_movie?
    return false unless movie

    set_state
    InsertRecommendedMoviesJob.perform_later(movie.imdb)
  end

  private

  def valid_movie?
    return false if InvalidMovie.exists?(imdb:)

    movie = Movie.find_by(imdb:)
    if movie.blank?
      begin
        return save_movie
      rescue StandardError
        InvalidMovie.create!(imdb:)
        return false
      end
    end

    movie
  end

  def set_state
    state = State.find_by(imdb:)

    if state.blank?
      save!
    else
      state.update!(value:)
    end
  end

  def save_movie
    get_movie = GetMovie.new(imdb)
    Movie.from_get_movie(get_movie)
  end
end
