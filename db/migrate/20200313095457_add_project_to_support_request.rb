class AddProjectToSupportRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :support_requests, :project_id, :integer
    add_foreign_key :support_requests, :projects
  end
end
