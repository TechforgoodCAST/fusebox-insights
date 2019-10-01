# frozen_string_literal: true

class Outcome < ApplicationRecord
  belongs_to :iteration
  has_many :check_in_ratings, dependent: :destroy

  validates :title, :success_criteria, presence: true
end
