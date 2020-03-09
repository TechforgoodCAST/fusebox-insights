# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.text :name, null: false
      t.text :website, null: false
      t.timestamps
    end

    create_table :offers do |t|
      t.references :provider, foreign_key: true
      t.string :title, null: false
      t.text :short_description
      t.text :long_description
      t.string :sign_up_link
      t.integer :duration
      t.timestamps
    end
  end
end
