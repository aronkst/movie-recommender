class State < ApplicationRecord
  validates :imdb, :value, presence: true
  validates :value, inclusion: { in: %w(like dislike watch_later block) }
  validates :imdb, uniqueness: true

  has_one :movie, class_name: "Movie", primary_key: :imdb, foreign_key: :imdb

  def set_movie
    movie = valid_movie?
    return false unless movie

    set_state
    # TODO Call job
  end

  private

  def valid_movie?
    return false if InvalidMovie.exists?(imdb: imdb)

    movie = Movie.find_by(imdb: imdb)
    if movie.blank?
      begin
        return save_movie
      rescue
        InvalidMovie.create!(imdb: imdb)
        return false
      end
    end

    movie
  end

  def set_state
    state = State.find_by(imdb: imdb)

    if state.blank?
      save!
    else
      state.update!(value: value)
    end
  end

  def save_movie
    get_movie = GetMovie.new(imdb)
    Movie.from_get_movie(get_movie)
  end
end
