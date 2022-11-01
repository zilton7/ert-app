class ChangeTypeOfImdbRatingForEpisodes < ActiveRecord::Migration[6.1]
  def up
    change_column(:episodes, :imdb_rating, :float, precision: 3, scale: 1)
  end

  def down
    change_column(:episodes, :imdb_rating, :integer)
  end
end
