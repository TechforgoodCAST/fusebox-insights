# frozen_string_literal: true

class AddProjectToAssumptions < ActiveRecord::Migration[5.2]
  def change
    add_column :assumptions, :project_id, :bigint, null: true
    add_foreign_key :assumptions, :projects, column: :project_id
  end
end
