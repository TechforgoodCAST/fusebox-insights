# frozen_string_literal: true

require 'test_helper'

class MilestoneTest < ActiveSupport::TestCase
  setup { @subject = build(:milestone) }

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end

  test('deadline required') { assert_present(:deadline) }

  test('description required') { assert_present(:description) }

  test('status required') { assert_present(:status) }

  test()'status defaults to planned') { assert_equal('planned', @subject.status) }

  test('title required') { assert_present(:title) }
end
