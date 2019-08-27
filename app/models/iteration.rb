# frozen_string_literal: true

class Iteration < ApplicationRecord
  belongs_to :project

  has_many :check_ins, dependent: :destroy

  has_many :outcomes, dependent: :destroy
  accepts_nested_attributes_for :outcomes, allow_destroy: true

  enum status: { planned: 0, committed: 1, completed: 2 }, _prefix: :status

  validates :title, presence: true
  validates :start_date, :debrief_date, presence: true, if: :status_committed?
  validates :outcomes, length: {
    minimum: 1, maximum: 5, message: 'must have between 1-5 outcomes defined'
  }, if: :status_committed?

  validate :cannot_be_longer_than_12_weeks
  validate :cannot_be_shorter_than_2_weeks
  validate :debrief_date_cannot_be_before_start_date
  validate :start_date_cannot_be_in_the_past

  audited

  def draftable?
    status_planned? || status_changed?(from: 'planned', to: 'committed')
  end

  private

  def cannot_be_longer_than_12_weeks
    return if dates_missing?

    errors.add(:debrief_date, "iteration can't be longer than 12 weeks") if number_of_weeks >= 12
  end

  def cannot_be_shorter_than_2_weeks
    return if dates_missing?

    errors.add(:debrief_date, "iteration can't be shorter than 2 weeks") if number_of_weeks < 2
  end

  def dates_missing?
    debrief_date.nil? || start_date.nil?
  end

  def debrief_date_cannot_be_before_start_date
    return if dates_missing?

    errors.add(:debrief_date, "can't be before start date") if debrief_date < start_date
  end

  def number_of_weeks
    (debrief_date - start_date).to_i / 7
  end

  def start_date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date&.past?
  end
end
