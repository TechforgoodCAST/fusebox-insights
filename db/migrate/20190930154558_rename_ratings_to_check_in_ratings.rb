class RenameRatingsToCheckInRatings < ActiveRecord::Migration[5.2]
  def change
    rename_table :ratings, :check_in_ratings
  end
end
