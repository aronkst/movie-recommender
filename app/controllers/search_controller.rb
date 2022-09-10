class SearchController < ApplicationController
  def index
    @movies = []
    @list_imdb = []

    if params[:query].present?
      search_movies = SearchMovies.new(params[:query])
      @movies = search_movies.movies
      @states = State.where(imdb: search_movies.list_imdb).to_a
    end
  end
end
