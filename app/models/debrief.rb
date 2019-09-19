# frozen_string_literal: true

class Debrief < ApplicationRecord
  belongs_to :iteration
  has_many :debrief_ratings, dependent: :destroy
  belongs_to :milestone, optional: true

  accepts_nested_attributes_for :debrief_ratings,
    reject_if: :all_blank,
    update_only: true,
    allow_destroy: true,
    limit: 5

  validates :milestone_completed, inclusion: [true, false]
  validates :completed_by, presence: true
end
