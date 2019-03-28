class AddAccountedForToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :accounted_for, :boolean, default: false
  end
end
