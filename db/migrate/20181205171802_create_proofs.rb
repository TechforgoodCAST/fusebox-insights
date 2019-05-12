# frozen_string_literal: true

class CreateProofs < ActiveRecord::Migration[5.2]
  def change
    create_table :proofs do |t|
      t.references :insight, foreign_key: true
      t.references :unknown, foreign_key: true
      t.bigint :author_id, index: true, null: false
      t.integer :confidence, null: false, default: 0

      t.timestamps
    end
  end
end
