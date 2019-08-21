class RenameDateToDeadline < ActiveRecord::Migration[5.2]
  def change
    rename_column :milestones, :date, :deadline
  end
end
