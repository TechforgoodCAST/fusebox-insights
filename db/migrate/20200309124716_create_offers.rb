# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :website, null: false
      t.timestamps
    end

    create_table :offers do |t|
      t.references :provider, foreign_key: true
      t.string :title, null: false
      t.text :short_description
      t.text :long_description
      t.string :sign_up_link
      t.string :logo_link
      t.integer :duration_category
      t.string :duration_description
      t.timestamps
    end
  end
end
