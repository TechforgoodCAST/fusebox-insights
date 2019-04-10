class AddAdminToProjectMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :project_members, :role, :string
  end
end
