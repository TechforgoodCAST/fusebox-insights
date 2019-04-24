class AddingCertainty < ActiveRecord::Migration[5.2]
  def change
    add_column :unknowns, :certainty, :boolean, :default => 0
  end
end
