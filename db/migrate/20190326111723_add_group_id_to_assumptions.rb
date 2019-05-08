class AddGroupIdToAssumptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :assumptions, :group, foreign_key: true
  end
end
