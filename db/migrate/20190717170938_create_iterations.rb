class CreateIterations < ActiveRecord::Migration[5.2]
  def change
    create_table :iterations do |t|
      t.string :title, null: false
      t.text :description
      t.date :start_date
      t.date :debrief_date
      t.integer :status, default: 0, null: false
      t.references :project, foreign_key: true, null: false

      t.timestamps
    end
  end
end
