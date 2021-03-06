# frozen_string_literal: true

class CreateFoci < ActiveRecord::Migration[5.2]
  def change
    create_table :foci do |t|
      t.references :user, foreign_key: true
      t.references :unknown, foreign_key: true

      t.timestamps
    end
  end
end
