class UpdateMilestoneFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :milestones, :date, :completed_on
    rename_column :milestones, :name, :title

    remove_column :milestones, :badge, :string
    remove_column :milestones, :completed, :boolean

    change_column :milestones, :project_id, :bigint, null: false
    change_column :milestones, :success_criteria, :text
    change_column :milestones, :title, :string

    add_column :milestones, :deadline, :date
    add_column :milestones, :status, :integer, default: 0, null: false
  end
end
