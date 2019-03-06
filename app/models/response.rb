# frozen_string_literal: true

class Response
  include ActiveModel::Model

  CONFIDENCE = {
    'No change' => 0, 'More confident' => 1, 'Less confident' => -1
  }.freeze

  attr_accessor :author, :confidence, :description, :title, :unknown, :type

  validates :author, :unknown, presence: true
  validates :title, :confidence, presence: true, if: :is_insight?
  validates :description, presence: true, if: :is_comment?

  def valid?
    if is_insight? 
      if Insight.where(title: title).any?
        super
        errors.add(:title, 'has already been taken')
        false
      else
        super
      end
    else
      super
    end
  end

  def save
    if is_insight?
      insight = author.insights.create!(title: title, description: description)
      author.proofs.create!(
        confidence: confidence, insight: insight, unknown: unknown
      )
    elsif is_comment?
      author.comments.create!(description: description, unknown: unknown)
    end
  end

  private
    def is_insight?
      type == 'Insight'
    end

    def is_comment?
      type == 'Comment'
    end
end
