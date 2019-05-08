class RenameUnknowns < ActiveRecord::Migration[5.2]
  def change

    rename_table :unknowns, :assumptions

    rename_column :comments, :unknown_id, :assumption_id
    rename_column :foci, :unknown_id, :assumption_id
    rename_column :proofs, :unknown_id, :assumption_id

  end
end
