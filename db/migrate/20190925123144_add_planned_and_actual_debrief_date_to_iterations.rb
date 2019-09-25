# frozen_string_literal: true

class AddPlannedAndActualDebriefDateToIterations < ActiveRecord::Migration[5.2]
  def change
    rename_column :iterations, :debrief_date, :planned_debrief_date
    add_column :iterations, :actual_debrief_date, :date
  end
end
