class AddGroupIdToUnknowns < ActiveRecord::Migration[5.2]
  def change
    add_reference :unknowns, :group, foreign_key: true
  end
end
