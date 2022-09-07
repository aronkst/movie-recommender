class StatesController < ApplicationController
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
end
