class Rating < ApplicationRecord
  belongs_to :check_in
  belongs_to :outcome
  
  enum ratings: { strong: 0, shaky: 100, struggling: 200 }, _prefix: :rating
end
