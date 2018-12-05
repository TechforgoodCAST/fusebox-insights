# frozen_string_literal: true

require 'test_helper'

class FocusTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
    @unknown = build(:unknown, author: @user)
  end

  test 'one per user and unknown' do
    @subject = create(:focus, user: @user, unknown: @unknown)
    assert_unique(:unknown)
  end
end
