# frozen_string_literal: true

class InsightBelongsToProject < ActiveRecord::Migration[5.2]
  def change
    Insight.all.each do |insight|
      insight.update!(project_id: insight.assumption.project_id)
    end

    change_column_null :insights, :project_id, false
  end
end
