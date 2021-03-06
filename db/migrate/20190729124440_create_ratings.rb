class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.text :comments
      t.references :check_in, foreign_key: true, null: false
      t.references :outcome, foreign_key: true, null: false

      t.timestamps
    end
  end
end
