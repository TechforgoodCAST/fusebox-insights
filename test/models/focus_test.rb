# frozen_string_literal: true

require 'test_helper'

class FocusTest < ActiveSupport::TestCase
  setup { @subject = create(:focus) }

  test('one per user and assumption') { assert_unique(:assumption) }
end
