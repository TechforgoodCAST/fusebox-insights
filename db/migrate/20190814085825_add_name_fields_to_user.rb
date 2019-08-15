# frozen_string_literal: true

class AddNameFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :memberships, :role, :string, default: 'Admin'
    add_column :memberships, :role, :integer, null: false, default: 0
    add_index :memberships, %i[project_id user_id], unique: true

    change_column :users, :username, :string, null: true
    rename_column :users, :username, :full_name
    add_column :users, :display_name, :string
    remove_column :users, :is_staff, :boolean, default: false

    add_column :projects, :more_details, :text

    drop_table :comments
    drop_table :pg_search_documents
  end
end
