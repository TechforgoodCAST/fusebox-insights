# frozen_string_literal: true

class Response
  include ActiveModel::Model

  CONFIDENCE = {
    'No change' => 0, 'More confident' => 1, 'Less confident' => -1
  }.freeze

  attr_accessor :author, :confidence, :description, :title, :assumption, :type

  validates :author, :assumption, :description, presence: true
  validates :title, :confidence, presence: true, if: :insight?

  def valid?
    if insight?
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
    if valid?
      if insight?
        author.insights.create!(
          assumption: assumption,
          confidence: confidence,
          description: description,
          project: assumption.project,
          title: title
        )
      elsif comment?
        author.comments.create!(description: description, assumption: assumption)
      end
    end
  end

  private

  def insight?
    type == 'Insight'
  end

  def comment?
    type == 'Comment'
  end
end
