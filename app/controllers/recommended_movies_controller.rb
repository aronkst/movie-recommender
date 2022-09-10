class RecommendedMoviesController < ApplicationController
  def index
    @movies = Movie.recommended(params['page'])
    @movies = Movie.filter(@movies, params)
  end
end
