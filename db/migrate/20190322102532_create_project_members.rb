class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|

      t.bigint :user_id
      t.bigint :project_id

      t.timestamps
    end
  end
end
