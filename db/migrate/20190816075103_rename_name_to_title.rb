class RenameNameToTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column :milestones, :name, :title
  end
end
