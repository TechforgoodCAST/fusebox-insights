class RenameProjectMembers < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_members, :memberships
  end
end
