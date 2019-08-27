# frozen_string_literal: true

class Outcome < ApplicationRecord
  belongs_to :iteration
  has_many :ratings, dependent: :destroy

  validates :title, :success_criteria, presence: true
end
