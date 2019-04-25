class FixCertaintyColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :unknowns, :certainty
    add_column :unknowns, :certainty, :integer, :default => 0
  end
end
