class AddSuccessCriteriaToMilestones < ActiveRecord::Migration[5.2]
  def change
    add_column :milestones, :success_criteria, :string
    rename_column :milestones, :title, :name
  end
end
