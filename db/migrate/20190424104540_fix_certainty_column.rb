class FixCertaintyColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :assumptions, :certainty
    add_column :assumptions, :certainty, :integer, :default => 0
  end
end
