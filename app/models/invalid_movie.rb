class InvalidMovie < ApplicationRecord
  validates :imdb, presence: true
  validates :imdb, uniqueness: true
end
