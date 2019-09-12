class Debrief < ApplicationRecord
  belongs_to :iteration
  has_many :debrief_ratings
  belongs_to :milestone
  
  accepts_nested_attributes_for :debrief_ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
  
  enum milestone_completed: { no: 0, yes: 1 }
  
  validates :complete_at, :completed_by, presence: true
end
