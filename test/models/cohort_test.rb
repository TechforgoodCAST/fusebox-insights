# frozen_string_literal: true

require 'test_helper'

class CohortTest < ActiveSupport::TestCase
  setup { @subject = build(:cohort) }

  test('name required') { assert_present(:name) }
end
