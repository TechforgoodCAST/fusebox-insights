# frozen_string_literal: true

require 'test_helper'

class OutcomeTest < ActiveSupport::TestCase
  setup { @subject = build(:outcome) }

  test 'belongs to iteration' do
    assert_instance_of(Iteration, @subject.iteration)
    assert_present(:iteration, msg: 'must exist')
  end

  test('title required') { assert_present(:title) }

  test('success criteria required') { assert_present(:success_criteria) }
end
