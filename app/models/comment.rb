# frozen_string_literal: true

class Comment
  include ActiveModel::Model

  CONFIDENCE = {
    'No change' => 0, 'More confident' => 1, 'Less confident' => -1
  }.freeze

  attr_accessor :author, :confidence, :title, :unknown

  validates :author, :confidence, :title, :unknown, presence: true

  def valid?
    if Insight.where(title: title).any?
      super
      errors.add(:title, 'has already been taken')
      false
    else
      super
    end
  end

  def save
    if valid?
      insight = author.insights.create!(title: title)
      author.proofs.create!(
        confidence: confidence, insight: insight, unknown: unknown
      )
    else
      false
    end
  end
end
