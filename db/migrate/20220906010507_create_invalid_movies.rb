class CreateInvalidMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :invalid_movies do |t|
      t.string :imdb, null: false

      t.timestamps
    end

    add_index :invalid_movies, :imdb, unique: true
  end
end
