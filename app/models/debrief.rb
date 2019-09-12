class Debrief < ApplicationRecord
  belongs_to :iteration
  has_many :debrief_ratings
  
  accepts_nested_attributes_for :debrief_ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
  
  validates :complete_at, :completed_by, :milestone_completed, presence: true
end
