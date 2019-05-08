class RemoveGroupsForeignKeyFromAssumptions < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :assumptions, :groups
  end
end
