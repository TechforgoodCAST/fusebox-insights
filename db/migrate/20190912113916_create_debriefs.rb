class CreateDebriefs < ActiveRecord::Migration[5.2]
  def change
    create_table :debriefs do |t|
      t.text :notes
      t.bigint :completed_by, foreign_key: true, null: false
      t.boolean :milestone_completed
      t.references :milestone, foreign_key: true, null: true
      t.references :iteration, foreign_key: true, null: false

      t.timestamps
    end
  end
end
