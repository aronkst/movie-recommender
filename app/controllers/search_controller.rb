class SearchController < ApplicationController
  def index
    @movies = []

    unless params[:query].blank?
      search_movies = SearchMovies.new(params[:query])
      @movies = search_movies.movies
    end
  end
end
