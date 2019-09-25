# frozen_string_literal: true

class Iteration < ApplicationRecord
  belongs_to :project

  has_many :check_ins, dependent: :destroy
  has_one :debrief, dependent: :destroy

  has_many :outcomes, dependent: :destroy
  accepts_nested_attributes_for :outcomes, allow_destroy: true

  enum status: { planned: 0, committed: 1, completed: 2 }, _prefix: :status

  validates :title, presence: true
  validates :start_date, :planned_debrief_date, presence: true, if: :status_committed?
  validates :outcomes, length: {
    minimum: 1, maximum: 5, message: 'You must have between 1 and 5 outcomes defined'
  }, if: :status_committed?

  validate :cannot_be_longer_than_12_weeks
  validate :cannot_be_shorter_than_2_weeks
  validate :debrief_date_cannot_be_before_start_date

  audited

  def debrief_date
    actual_debrief_date || planned_debrief_date
  end

  def draftable?
    status_planned? || status_changed?(from: 'planned', to: 'committed')
  end

  def warning(check_in_gap: -14, debrief_gap: 4)
    return unless status_committed?

    return :check_in_due if check_in_distance < check_in_gap && debrief_distance > debrief_gap

    return :debrief_due if debrief_distance.negative?
  end

  private

  def cannot_be_longer_than_12_weeks
    return if dates_missing?

    errors.add(:planned_debrief_date, "iteration can't be longer than 12 weeks") if number_of_weeks >= 12
  end

  def cannot_be_shorter_than_2_weeks
    return if dates_missing?

    errors.add(:planned_debrief_date, "iteration can't be shorter than 2 weeks") if number_of_weeks < 2
  end

  def check_in_date
    last_check_in_at&.to_date || start_date
  end

  def check_in_distance
    (check_in_date - Time.zone.today).to_i
  end

  def dates_missing?
    planned_debrief_date.nil? || start_date.nil?
  end

  def debrief_date_cannot_be_before_start_date
    return if dates_missing?

    errors.add(:planned_debrief_date, "can't be before start date") if planned_debrief_date < start_date
  end

  def debrief_distance
    (planned_debrief_date - Time.zone.today).to_i
  end

  def number_of_weeks
    (planned_debrief_date - start_date).to_i / 7
  end
end
