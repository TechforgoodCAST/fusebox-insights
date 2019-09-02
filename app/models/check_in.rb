class CheckIn < ApplicationRecord
  belongs_to :iteration
  has_many :ratings
  
  accepts_nested_attributes_for :ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
  
  validates :complete_at, :completed_by, :notes, presence: true
  
  def on_track
    max = 0;
    self.ratings.each do |rating|
      max = [rating.score, max].max;
    end
    
    return Rating.ratings.key(max);
  end
  
end
