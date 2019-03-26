# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :is_private, default: true, null: false
      t.string :slug, null: false
      t.bigint :user_id, index: true, null: false

      t.timestamps
    end

    add_index :projects, :slug, unique: true
  end
end
