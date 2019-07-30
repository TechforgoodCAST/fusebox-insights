class AddStatusToIteration < ActiveRecord::Migration[5.2]
  def change
    add_column :iterations, :status, :integer
  end
end
