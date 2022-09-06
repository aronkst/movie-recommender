class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :imdb
      t.string :title
      t.integer :year
      t.string :summary
      t.float :score
      t.integer :amount_of_votes
      t.integer :metascore
      t.integer :points
      t.string :genres
      t.string :recommended_movies
      t.string :url_cover

      t.timestamps
    end

    add_index :movies, :imdb, unique: true
  end
end
