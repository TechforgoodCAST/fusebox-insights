class Cohort < ApplicationRecord
  has_many :projects
  has_and_belongs_to_many :offers
  
  validates :name, presence: true
end
