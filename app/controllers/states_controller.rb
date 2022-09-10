class StatesController < ApplicationController
  before_action :check_state, only: [:index]

  def index
    @movies = Movie.state(params[:state], params["page"])
    @movies = filter_movies(@movies)
  end

  def upsert
    @state = State.new(imdb: params[:imdb], value: params[:value])
    @saved = @state.set_movie

    respond_to do |format|
      format.html do
        if @saved
          redirect_to states_index_url(params[:value])
        else
          redirect_to states_index_url(params[:value]), alert: 'Could not save the status of this movie'
        end
      end
      format.turbo_stream
    end
  end

  private

  def check_state
    raise ActionController::RoutingError.new('Not Found') unless State::VALID_VALUES.include?(params[:state])
  end
end
