class CreateDebriefs < ActiveRecord::Migration[5.2]
  def change
    create_table :debriefs do |t|
      t.text :notes
      t.datetime :complete_at
      t.bigint :completed_by, foreign_key: true
      t.bigint :milestone_completed, foreign_key: true
      t.references :milestone, foreign_key: true
      t.references :iteration, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
