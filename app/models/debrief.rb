class Debrief < ApplicationRecord
  belongs_to :iteration
  has_many :debrief_ratings
  belongs_to :milestone
  
  accepts_nested_attributes_for :debrief_ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
  
  validates_inclusion_of :milestone_completed, in: [true, false]
  validates :completed_by, presence: true
end
