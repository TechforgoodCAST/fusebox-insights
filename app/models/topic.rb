class Topic < ApplicationRecord
  has_and_belongs_to_many :offers
  
  validates :title, :short_desc, :long_desc, presence: true
end
