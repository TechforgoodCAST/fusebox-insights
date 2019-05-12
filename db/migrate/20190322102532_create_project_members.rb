# frozen_string_literal: true

class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.bigint :user_id, index: true, null: false
      t.bigint :project_id, index: true, null: false

      t.timestamps
    end
  end
end
