# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @subject = build(:user) }

  test('has many #authored unknowns') do
    create_list(:unknown, 2, author: @subject)
    assert_equal(2, @subject.authored.size)
  end

  test('#username present') { assert_present(:username) }

  test('valid') { assert(@subject.valid?) }
end
