class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.integer :number
      t.references :season, null: false, foreign_key: true
      t.string :imdb_id
      t.integer :imdb_rating

      t.timestamps
    end
  end
end
