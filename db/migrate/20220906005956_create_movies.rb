class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :imdb, null: false
      t.string :title, null: false
      t.integer :year, null: false
      t.string :summary, null: false
      t.float :score, null: false
      t.integer :amount_of_votes, null: false
      t.integer :metascore, null: false
      t.integer :points, null: false
      t.string :genres, null: false, array: true, default: []
      t.string :recommended_movies, null: false, array: true, default: []
      t.string :url_cover, null: false

      t.timestamps
    end

    add_index :movies, :imdb, unique: true
  end
end
