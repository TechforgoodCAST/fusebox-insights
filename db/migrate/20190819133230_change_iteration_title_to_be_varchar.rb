class ChangeIterationTitleToBeVarchar < ActiveRecord::Migration[5.2]
  def change
    change_column :iterations, :title, :string
    change_column :milestones, :title, :string
    change_column :outcomes, :title, :string
  end
end
