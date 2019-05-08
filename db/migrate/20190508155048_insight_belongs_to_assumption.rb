# frozen_string_literal: true

class InsightBelongsToAssumption < ActiveRecord::Migration[5.2]
  def change
    add_reference :insights, :assumption, index: true, foreign_key: true
    add_column :insights, :confidence, :integer, null: false, default: 0

    reversible do |dir|
      dir.up do
        Proof.all.each do |proof|
          proof.insight.update(
            confidence: proof.confidence,
            assumption: proof.assumption
          )
        end
        Proof.destroy_all
      end
      dir.down do
        Insight.all.each do |insight|
          Proof.create!(
            author: insight.author,
            confidence: insight.confidence,
            insight: insight,
            assumption: insight.assumption
          )
        end
        Insight.update_all(assumption_id: nil)
      end
    end
  end
end
