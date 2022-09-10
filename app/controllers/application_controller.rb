class ApplicationController < ActionController::Base
  def filter_movies(movies)
    movies = movies.where(imdb: params["imdb"]) if params["imdb"].present?
    movies = movies.where("title ILIKE ?", "%#{params["title"]}%") if params["title"].present?
    movies = movies.where(year: params["year"]) if params["year"].present?
    movies = movies.where("summary ILIKE ?", "%#{params["summary"]}%") if params["summary"].present?
    movies = movies.where("score >= ?", params["score"]) if params["score"].present?
    movies = movies.where("amount_of_votes >= ?", params["amount_of_votes"]) if params["amount_of_votes"].present?
    movies = movies.where("metascore >= ?", params["metascore"]) if params["metascore"].present?
    movies = movies.where("points >= ?", params["points"]) if params["points"].present?
    movies = movies.where("? ILIKE ANY (genres)", params["genres"]) if params["genres"].present?
    movies
  end
end
