class Rating < ApplicationRecord
  belongs_to :check_in
  belongs_to :outcome
  
  enum ratings: { on_track: 0, at_risk: 100, off_track: 200 }, _prefix: :rating
  
  validates :score, :comments, presence: true
end
