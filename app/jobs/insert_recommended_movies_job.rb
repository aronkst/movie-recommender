class InsertRecommendedMoviesJob < ApplicationJob
  queue_as :default

  def perform(imdb)
    movie = Movie.find_by!(imdb:)
    movie.recommended_movies.each do |recommended_movie_imdb|
      next if InvalidMovie.exists?(imdb: recommended_movie_imdb)
      next if Movie.exists?(imdb: recommended_movie_imdb)

      begin
        get_movie = GetMovie.new(recommended_movie_imdb)
        Movie.from_get_movie(get_movie)
      rescue StandardError
        next
      end
    end
  end
end
