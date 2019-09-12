class DebriefRating < ApplicationRecord
  belongs_to :debrief
  belongs_to :outcome
  
  enum ratings: { no: 0, inconclusive: 100, yes: 200 }, _prefix: :rating
  
  validates :score, :comments, presence: true
end
