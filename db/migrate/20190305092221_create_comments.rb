# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :unknown, foreign_key: true
      t.bigint :author_id, index: true, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
