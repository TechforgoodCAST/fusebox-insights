class Outcome < ApplicationRecord
  belongs_to :iteration
  has_many :ratings
  
  validates :title, :description, presence: true
end
