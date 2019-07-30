class ChangeCommentsAssociation < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :assumption_id
    add_reference :comments, :outcome
  end
end
