# frozen_string_literal: true

class DebriefRating < ApplicationRecord
  belongs_to :debrief
  belongs_to :outcome

  SCORES = { 0 => 'No', 100 => 'Inconclusive', 200 => 'Yes' }.freeze

  def get_score
    SCORES[score]
  end

  validates :score, :comments, presence: true
end
