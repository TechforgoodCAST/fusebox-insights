# frozen_string_literal: true

class UnknownsProjectIdNotNull < ActiveRecord::Migration[5.2]
  def change
    add_index :unknowns, :project_id
    change_column_null :unknowns, :project_id, false
  end
end
