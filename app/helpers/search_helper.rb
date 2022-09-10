module SearchHelper
  def get_state(states, imdb)
    states.find { |s| s.imdb == imdb } || State.new(imdb:)
  end
end
