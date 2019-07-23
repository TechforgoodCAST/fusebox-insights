class Programme < ApplicationRecord
  
  has_many :iterations
  has_many :milestones
  
  validates :title, presence: true,
                    length: { minimum: 5 }
end
