class Outcome < ApplicationRecord
  belongs_to :iteration
  has_many :ratings
end
