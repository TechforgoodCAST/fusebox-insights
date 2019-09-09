class AddLastCheckInAtToIteration < ActiveRecord::Migration[5.2]
  def change
    add_column :iterations, :last_check_in_at, :datetime
  end
end
