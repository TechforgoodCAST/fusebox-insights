class RenamePrivateToIsPrivate < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :private, :is_private
  end
end
