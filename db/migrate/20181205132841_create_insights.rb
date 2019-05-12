# frozen_string_literal: true

class CreateInsights < ActiveRecord::Migration[5.2]
  def change
    create_table :insights do |t|
      t.string :title, null: false
      t.text :description
      t.bigint :author_id, index: true, null: false

      t.timestamps
    end
  end
end
