class Cohort < ApplicationRecord
  has_many :projects
  has_many :offers
end
