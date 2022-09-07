class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states do |t|
      t.string :imdb, null: false
      t.string :value

      t.timestamps
    end

    add_index :states, :imdb, unique: true
  end
end
