class ProjectAuthorsViaProjectMembers < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :user_id, :author_id
    change_column :project_members, :role, :string, default: 'Admin'
  end
end
