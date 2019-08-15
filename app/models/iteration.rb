# frozen_string_literal: true

class Iteration < ApplicationRecord
  belongs_to :project

  has_many :check_ins, dependent: :destroy
  has_many :outcomes, dependent: :destroy

  accepts_nested_attributes_for :outcomes, reject_if: :all_blank, update_only: true, allow_destroy: true, limit: 5

  enum status: { draft: -100, planned: 0, in_progress: 100, completed: 200 }, _prefix: :status

  validates :title, :description, :start_date, :debrief_date, presence: true
end
