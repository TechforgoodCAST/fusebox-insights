class CreateOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :outcomes do |t|
      t.string :title, null: false
      t.string :success_criteria
      t.references :iteration, foreign_key: true, null: false

      t.timestamps
    end
  end
end
