# frozen_string_literal: true

require 'test_helper'

class FocusTest < ActiveSupport::TestCase
  setup { @subject = create(:focus) }

  test('one per user and unknown') { assert_unique(:unknown) }
end
