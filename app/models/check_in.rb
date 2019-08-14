class CheckIn < ApplicationRecord
  belongs_to :iteration
  has_many :ratings
  
  accepts_nested_attributes_for :ratings, 
    reject_if: :all_blank, 
    update_only: true,
    allow_destroy: true,
    limit: 5
  
  
  def on_track
    max = 0;
    self.ratings.each do |rating|
      max = [rating.score, max].max;
    end
    
    return Rating.ratings.key(max);
  end
  
#  def get_avg_score
#    sum = 0;
#    i = 0;
#    self.ratings.each do |rating|
#      sum += rating.score
#      i += 1;
#    end
#    avg = sum/i;
#    
#    return avg
#  end
  
  
end
