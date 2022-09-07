class State < ApplicationRecord
  def self.set_value(imdb, value)
    state = State.find_by(imdb: imdb)

    if state.blank?
      State.create!(imdb: imdb, value: value)
    else
      state.update!(value: state.value == value ? nil : value)
    end

    State.find_by(imdb: imdb)
  end
end
