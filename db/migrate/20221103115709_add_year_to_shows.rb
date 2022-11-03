class AddYearToShows < ActiveRecord::Migration[6.1]
  def change
    add_column :shows, :year, :string
  end
end
