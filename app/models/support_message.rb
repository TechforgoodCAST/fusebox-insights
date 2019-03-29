

class SupportMessage < ApplicationRecord
  ALLOWED_STATUSES = ['Pending', 'Incomplete', 'Complete'].freeze
  ALLOWED_OBJECTS = ['None', 'Unknown'].freeze
  VALID_EVENT_TYPES = ['create', 'read', 'update', 'delete', 'add_to_group'].freeze

  belongs_to :project, class_name: 'Project'
  validates :status, inclusion: { in: ALLOWED_STATUSES }
  validates :order, uniqueness: { scope: :project_id }
  validates :rule_object_type, inclusion: { in: ALLOWED_OBJECTS }
  validates :rule_event_type, inclusion: { in: VALID_EVENT_TYPES }
  validates :rule_occurrences, numericality: { greater_than_or_equal_to: 0 }
end
