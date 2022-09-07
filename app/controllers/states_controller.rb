class StatesController < ApplicationController
  def upsert
    @state = State.set_value(params[:imdb], params[:value])

    respond_to do |format|
      format.html { redirect_to root_url } # TODO
      format.turbo_stream
    end
  end
end
