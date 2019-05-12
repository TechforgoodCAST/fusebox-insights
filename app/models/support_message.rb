# frozen_string_literal: true

class SupportMessage < ApplicationRecord
  ALLOWED_STATUSES = %w[Pending Incomplete Complete].freeze
  ALLOWED_OBJECTS = %w[None Assumption].freeze
  VALID_EVENT_TYPES = %w[create read update delete].freeze

  belongs_to :project

  validates :status, inclusion: { in: ALLOWED_STATUSES }
  validates :order, uniqueness: { scope: :project_id }
  validates :rule_object_type, inclusion: { in: ALLOWED_OBJECTS }
  validates :rule_event_type, inclusion: { in: VALID_EVENT_TYPES }
  validates :rule_occurrences, numericality: { greater_than_or_equal_to: 0 }
end
