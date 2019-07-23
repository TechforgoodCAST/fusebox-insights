class Iteration < ApplicationRecord
  belongs_to :programme
  
  has_many :outcomes,
    dependent: :destroy
  
  accepts_nested_attributes_for :outcomes, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true
  
end
