# frozen_string_literal: true

class CheckIn < ApplicationRecord
  belongs_to :iteration
  has_many :check_in_ratings, dependent: :destroy

  accepts_nested_attributes_for :check_in_ratings,
    reject_if: :all_blank,
    update_only: true,
    allow_destroy: true

  validates :completed_by, presence: true
end
