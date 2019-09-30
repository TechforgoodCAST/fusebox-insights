# frozen_string_literal: true

module CheckInsHelper
  def render_check_in_status(check_in)
    max = 0
    sum = 0
    check_in.check_in_ratings.each do |rating|
      max = [rating.score, max].max
      sum += max
    end

    if check_in.check_in_ratings.count * max == sum
      tag.span(CheckInRating::SCORES[max], class: 'tag ' + CheckInRating::SCORES[max].parameterize) + ' in all areas'
    else
      tag.span(CheckInRating::SCORES[max], class: 'tag ' + CheckInRating::SCORES[max].parameterize) + ' in some areas'
    end
  end
end
