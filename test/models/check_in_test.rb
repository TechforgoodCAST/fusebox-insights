# frozen_string_literal: true

require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  setup { @subject = build(:check_in) }

  test 'belongs to iteration' do
    assert_instance_of(Iteration, @subject.iteration)
    assert_present(:iteration, msg: 'must exist')
  end

  test('completed_by required') { assert_present(:completed_by) }
end
