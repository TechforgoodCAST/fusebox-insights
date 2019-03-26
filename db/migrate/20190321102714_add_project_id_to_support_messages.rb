class AddProjectIdToSupportMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :support_messages, :project_id, :bigint
  end
end
