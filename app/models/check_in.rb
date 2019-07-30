class CheckIn < ApplicationRecord
  belongs_to :iteration
  has_many :ratings
  
  accepts_nested_attributes_for :ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
end
