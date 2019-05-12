class AddDeletedAtToAssumption < ActiveRecord::Migration[5.2]
  def change
    add_column :assumptions, :deleted_at, :datetime
    add_index :assumptions, :deleted_at
  end
end
