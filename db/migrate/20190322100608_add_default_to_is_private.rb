class AddDefaultToIsPrivate < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :is_private, :boolean, default: true
  end
end
