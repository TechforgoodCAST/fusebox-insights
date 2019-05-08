class RemoveGroupsForeignKeyFromAssumptions < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :unknowns, :groups
  end
end
