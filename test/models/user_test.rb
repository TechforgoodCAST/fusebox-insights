# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @subject = build(:user) }

  test('has many memberships') { assert_has_many(:memberships) }

  test('dependent destroys memberships') { assert_destroys(:memberships) }

  test('has many projects') { assert_has_many(:projects) }

  test('email required') { assert_present(:email) }

  test('full_name required') { assert_present(:full_name) }

  test('password required') { assert_present(:password) }
end
