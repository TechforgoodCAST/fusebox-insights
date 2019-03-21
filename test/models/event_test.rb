# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup { @subject = build(:event) }

  test 'has one #triggerable' do
    create(:unknown, triggerable: @subject)
    assert_equal(1, @subject.triggerable.size)
  end
end
