class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.text :notes
      t.datetime :complete_at
      t.bigint :completed_by, foreign_key: true, null: false
      t.references :iteration, foreign_key: true, null: false

      t.timestamps
    end
  end
end
