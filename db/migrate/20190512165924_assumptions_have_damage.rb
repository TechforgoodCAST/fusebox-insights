# frozen_string_literal: true

class AssumptionsHaveDamage < ActiveRecord::Migration[5.2]
  def change
    add_column :assumptions, :damage, :integer
  end
end
