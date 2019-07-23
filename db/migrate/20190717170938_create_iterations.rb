class CreateIterations < ActiveRecord::Migration[5.2]
  def change
    create_table :iterations do |t|
      t.text :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
