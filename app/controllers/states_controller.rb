class StatesController < ApplicationController
  before_action :check_state, only: [:index]

  def index
    @movies = Movie.includes(:state).where(state: { value: params[:state] })
    @movies = @movies.where("title LIKE ?", "%#{params["title"]}%") if params["title"].present? # TODO
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
