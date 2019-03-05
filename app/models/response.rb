# frozen_string_literal: true

class Response
  include ActiveModel::Model

  CONFIDENCE = {
    'No change' => 0, 'More confident' => 1, 'Less confident' => -1
  }.freeze

  attr_accessor :author, :confidence, :description, :title, :unknown, :type

  validates :author, :unknown, presence: true

  def valid?
    if type == 'Insight' 
      if Insight.where(title: title).any?
        super
        errors.add(:title, 'has already been taken')
        false
      elsif title == "" || title.nil?
        super
        errors.add(:title, "can't be blank")
        false
      elsif confidence == "" || confidence.nil?
        super
        errors.add(:confidence, "can't be blank")
        false
      else
        super
      end
    elsif type == 'Comment'
      if description == "" || description.nil?
        super
        errors.add(:description, "can't be blank")
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
      if type == 'Insight'
        insight = author.insights.create!(title: title, description: description)
        author.proofs.create!(
          confidence: confidence, insight: insight, unknown: unknown
        )
      elsif type == 'Comment'
        false
      end
    else
      false
    end
  end
end
