# frozen_string_literal: true

module CheckInsHelper
  def render_check_in_status(check_in)
    max = 0
    sum = 0
    check_in.ratings.each do |rating|
      max = [rating.score, max].max
      sum += max
    end

    if check_in.ratings.count * max == sum
      tag.span(Rating::SCORES[max], class: 'tag ' + Rating::SCORES[max].parameterize) + ' in all areas'
    else
      tag.span(Rating::SCORES[max], class: 'tag ' + Rating::SCORES[max].parameterize) + ' in some areas'
    end
  end
end
