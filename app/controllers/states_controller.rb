class StatesController < ApplicationController
  before_action :check_state, only: [:index]

  def index
    @movies = Movie.get_from_state(params[:state], params["page"])
    @movies = filter_movies(@movies)
  end

  def upsert
    @state = State.new(imdb: params[:imdb], value: params[:value])
    @saved = @state.set_movie

    respond_to do |format|
      format.html do
        if @saved
          redirect_to root_url # TODO
        else
          redirect_to root_url # TODO
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
