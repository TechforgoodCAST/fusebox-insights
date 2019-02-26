# frozen_string_literal: true

class Response
  include ActiveModel::Model

  CONFIDENCE = {
    'No change' => 0, 'More confident' => 1, 'Less confident' => -1
  }.freeze

  TYPE = {
    'Insight' => 'insight', 'Comment' => 'comment'
  }.freeze


  attr_accessor :author, :confidence, :description, :title, :unknown, :type

  validates :author, :unknown, presence: true

  def valid?
    if type == TYPE['Insight']
      if Insight.where(title: title).any?
        super
        errors.add(:title, 'has already been taken')
        false
      elsif title == ""
        super
        errors.add(:title, 'cannot be blank')
        false
      elsif confidence == ""
        super
        errors.add(:confidence, 'cannot be blank')
        false
      else
        super
      end
    elsif type == TYPE['Comment']
      if description == ""
        super
        errors.add(:description, 'cannot be blank')
        false
      else
        super
      end
    end
  end

  def save
    if valid?
      if type == TYPE['Insight']
        insight = author.insights.create!(title: title, description: description)
        author.proofs.create!(
          confidence: confidence, insight: insight, unknown: unknown
        )
      elsif type == TYPE['Comment']
        author.comments.create!(description: description, unknown: unknown)
      end
    else
      false
    end
  end
end
