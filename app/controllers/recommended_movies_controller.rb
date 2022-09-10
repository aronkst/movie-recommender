class RecommendedMoviesController < ApplicationController
  def index
    @movies = Movie.recommended(params["page"])
    @movies = filter_movies(@movies)
  end
end
