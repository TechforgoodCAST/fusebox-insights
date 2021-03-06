# frozen_string_literal: true

class InsightBelongsToAssumption < ActiveRecord::Migration[5.2]
  def change
    add_reference :insights, :assumption, index: true, foreign_key: true
    add_column :insights, :confidence, :integer, null: false, default: 0

    add_reference :insights, :project, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        Proof.all.each do |proof|
          proof.insight.assumption = proof.assumption
          proof.insight.confidence = proof.confidence
          proof.insight.project = proof.assumption.project
          proof.insight.save!(touch: false)
        end
        Proof.destroy_all
      end
      dir.down do
        Insight.all.each do |insight|
          Proof.create!(
            author: insight.author,
            confidence: insight.confidence,
            insight: insight,
            assumption: insight.assumption,
            created_at: insight.created_at,
            updated_at: insight.updated_at
          )
        end
        Insight.update_all(assumption_id: nil)
      end
    end
  end
end
