class AddCohortToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :cohort_id, :integer
    add_foreign_key :projects, :cohorts
  end
end
