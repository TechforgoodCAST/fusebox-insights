# frozen_string_literal: true

class InsightBelongsToProject < ActiveRecord::Migration[5.2]
  def change
    Insight.all.each do |insight|
      insight.project_id = insight.assumption.project_id
      insight.save!(touch: false)
    end

    change_column_null :insights, :project_id, false
  end
end
