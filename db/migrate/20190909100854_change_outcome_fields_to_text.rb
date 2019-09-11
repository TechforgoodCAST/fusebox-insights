class ChangeOutcomeFieldsToText < ActiveRecord::Migration[5.2]
  def change
	  change_column :outcomes, :title, :text
	  change_column :outcomes, :success_criteria, :text
  end
end
