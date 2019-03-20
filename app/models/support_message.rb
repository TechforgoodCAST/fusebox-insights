
@ALLOWED_STATUSES = [
  'Pending',
  'Incomplete',
  'Complete',
]


class SupportMessage < ApplicationRecord
  # TODO: add relation to projects
  # TODO: add unique constraint to make sure order is unique with project
  validates :status, :inclusion => { :in @ALLOWED_STATUSES }
end
