class DebriefRating < ApplicationRecord
  belongs_to :debrief
  belongs_to :outcome
  
  SCORES = { 0 => 'No', 100 => 'Inconclusive', 200 => 'Yes' }
  
  def get_score
    return SCORES[self.score]
  end
  
  validates :score, :comments, presence: true
end
