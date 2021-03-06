class CreateDebriefRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :debrief_ratings do |t|
      t.integer :score
      t.text :comments
      t.references :debrief, foreign_key: true, null: false
      t.references :outcome, foreign_key: true, null: false

      t.timestamps
    end
  end
end
