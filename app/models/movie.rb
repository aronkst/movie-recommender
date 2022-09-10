class Movie < ApplicationRecord
  validates :imdb, :title, :year, :summary, :score, :amount_of_votes, :metascore, :points, :genres,
            :recommended_movies, :url_cover, presence: true
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :score, numericality: { only_float: true, in: 0..10 }
  validates :amount_of_votes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :metascore, numericality: { only_integer: true, in: 0..100 }
  validates :imdb, uniqueness: true

  has_one :state, class_name: 'State', primary_key: :imdb, foreign_key: :imdb

  after_create :grab_image

  paginates_per 8

  has_one_attached :cover do |attachable|
    attachable.variant :final, resize_to_limit: [284, 420]
  end

  def self.from_get_movie(get_movie)
    Movie.create!(imdb: get_movie.imdb, title: get_movie.title, year: get_movie.year, summary: get_movie.summary,
                  score: get_movie.score, amount_of_votes: get_movie.amount_of_votes, metascore: get_movie.metascore,
                  points: get_movie.points, url_cover: get_movie.url_cover, genres: get_movie.genres,
                  recommended_movies: get_movie.recommended_movies)
  end

  def self.state(state, page)
    includes(:state).where(state: { value: state }).order(points: :desc).page(page)
  end

  def self.recommended(page)
    like = State.where(value: 'like').pluck(:imdb)
    dislike = State.where(value: 'dislike').pluck(:imdb)
    watch_later = State.where(value: 'watch_later').pluck(:imdb)
    block = State.where(value: 'block').pluck(:imdb)

    recommended_movies = where(imdb: like).pluck(:recommended_movies).flatten
    recommended_movies -= (like + dislike + watch_later + block)

    includes(:state).where(imdb: recommended_movies).order(points: :desc).page(page)
  end

  def self.filter(movies, params)
    movies = movies.where(imdb: params['imdb']) if params['imdb'].present?
    movies = movies.where('title ILIKE ?', "%#{params['title']}%") if params['title'].present?
    movies = movies.where(year: params['year']) if params['year'].present?
    movies = movies.where('summary ILIKE ?', "%#{params['summary']}%") if params['summary'].present?
    movies = movies.where('score >= ?', params['score']) if params['score'].present?
    movies = movies.where('amount_of_votes >= ?', params['amount_of_votes']) if params['amount_of_votes'].present?
    movies = movies.where('metascore >= ?', params['metascore']) if params['metascore'].present?
    movies = movies.where('points >= ?', params['points']) if params['points'].present?
    movies = movies.where('? ILIKE ANY (genres)', params['genres']) if params['genres'].present?
    movies
  end

  private

  def grab_image
    downloaded_image = URI.parse(url_cover).open
    cover.attach(io: downloaded_image, filename: "#{imdb}.jpg")
  end
end
