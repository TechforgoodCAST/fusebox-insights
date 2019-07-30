class CreateCheckIns < ActiveRecord::Migration[5.2]
  def change
    create_table :check_ins do |t|
      t.text :notes
      t.date :date
      t.boolean :complete
      t.references :iteration, foreign_key: true

      t.timestamps
    end
  end
end
