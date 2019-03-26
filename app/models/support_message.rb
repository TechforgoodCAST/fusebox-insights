

class SupportMessage < ApplicationRecord
  @ALLOWED_STATUSES = [
    'Pending',
    'Incomplete',
    'Complete',
  ]
  belongs_to :project, class_name: 'Project'
  validates :status, inclusion: { :in => @ALLOWED_STATUSES }
  validates :order, uniqueness: { scope: :project_id }
end
