class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.text :title
      t.text :description
      t.date :date
      t.boolean :completed
      t.string :badge
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
