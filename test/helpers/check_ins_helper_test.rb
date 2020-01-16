# frozen_string_literal: true

require 'test_helper'

class CheckInsHelperTest < ActionView::TestCase
  include ActionView::Helpers::TagHelper
  setup do
    @on_track_rating = build(:check_in_rating, score: 0)
    @at_risk_rating = build(:check_in_rating, score: 100)
    @off_track_rating = build(:check_in_rating, score: 200)
  end

  test "'check in status says 'for some areas' when ratings are mixed" do
    # All off track
    @check_in = create(:check_in, check_in_ratings: [@on_track_rating, @at_risk_rating, @off_track_rating])

    span = make_span(200) + ' in some areas'
    assert_equal(span, render_check_in_status(@check_in))
  end

  test "'check in status says 'for all areas' when ratings are not" do
    # All the same
    @check_in = create(:check_in, check_in_ratings: [@on_track_rating, @on_track_rating])

    span = make_span(0) + ' in all areas'
    assert_equal(span, render_check_in_status(@check_in))
  end

  private

  def make_span(score)
    tag.span(CheckInRating::SCORES[score], class: 'tag ' + CheckInRating::SCORES[score].parameterize)
  end
end
