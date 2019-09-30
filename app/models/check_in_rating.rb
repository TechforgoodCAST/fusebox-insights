# frozen_string_literal: true

class CheckInRating < ApplicationRecord
  belongs_to :check_in
  belongs_to :outcome

  SCORES = { 0 => 'On track', 100 => 'At risk', 200 => 'Off track' }.freeze

  def get_score
    SCORES[score]
  end

  validates :score, :comments, presence: true
end
