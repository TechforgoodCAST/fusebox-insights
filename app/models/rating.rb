class Rating < ApplicationRecord
  belongs_to :check_in
  belongs_to :outcome
  
  SCORES = { 0 => 'On track', 100 => 'At risk', 200 => 'Off track' }
  
  def get_score
    return SCORES[self.score]
  end
	
  validates :score, :comments, presence: true
end
