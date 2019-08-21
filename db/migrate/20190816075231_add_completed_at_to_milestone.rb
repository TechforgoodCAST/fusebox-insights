class AddCompletedAtToMilestone < ActiveRecord::Migration[5.2]
  def change
    add_column :milestones, :completed_at, :date
  end
end
