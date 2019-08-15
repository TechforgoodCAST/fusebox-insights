class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.string :title, null: false
      t.text :description
      t.text :success_criteria
      t.datetime :completed_at
      t.date :deadline
      t.integer :status, default: 0, null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
