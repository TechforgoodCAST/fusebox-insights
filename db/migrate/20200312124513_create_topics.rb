class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :short_desc
      t.text :long_desc

      t.timestamps
    end
  end
end
