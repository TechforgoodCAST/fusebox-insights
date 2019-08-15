class CreateOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :outcomes do |t|
      t.text :title, null: false
      t.text :description
      t.references :iteration, foreign_key: true, null: false

      t.timestamps
    end
  end
end
