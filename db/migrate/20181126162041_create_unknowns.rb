class CreateUnknowns < ActiveRecord::Migration[5.2]
  def change
    create_table :unknowns do |t|
      t.string :title, null: false
      t.text :description
      t.bigint :author_id, index: true, null: false

      t.timestamps
    end
  end
end
