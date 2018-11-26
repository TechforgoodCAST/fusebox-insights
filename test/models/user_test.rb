# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @subject = build(:user) }

  test('valid') { assert(@subject.valid?) }

  test('#email present') { assert_present(:email) }

  test('#username present') { assert_present(:username) }
end
