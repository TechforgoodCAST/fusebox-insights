# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup { @subject = build(:project) }

  test('has many iterations') { assert_has_many(:iterations) }

  test('dependent destroys iterations') { assert_destroys(:iterations) }

  test('has many memberships') { assert_has_many(:memberships) }

  test('dependent destroys memberships') { assert_destroys(:memberships) }

  test('has many milestones') { assert_has_many(:milestones) }

  test('dependent destroys milestones') { assert_destroys(:milestones) }

  test('description required') { assert_present(:description) }

  test('title required') { assert_present(:title) }
end
