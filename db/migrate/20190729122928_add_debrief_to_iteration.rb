class AddDebriefToIteration < ActiveRecord::Migration[5.2]
  def change
    add_column :iterations, :debrief_date, :date
  end
end
