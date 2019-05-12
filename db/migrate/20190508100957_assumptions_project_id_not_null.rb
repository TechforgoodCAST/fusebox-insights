# frozen_string_literal: true

class AssumptionsProjectIdNotNull < ActiveRecord::Migration[5.2]
  def change
    add_index :assumptions, :project_id
    change_column_null :assumptions, :project_id, false
  end
end
