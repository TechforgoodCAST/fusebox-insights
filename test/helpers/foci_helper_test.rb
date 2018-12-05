# frozen_string_literal: true

require 'test_helper'

class FociHelperTest < ActionView::TestCase
  test "should return the user's full name" do
    assert_equal(
      Date.new(2018, 12, 14),
      next_reminder_date(Date.new(2018, 12, 7))
    )
  end
end
