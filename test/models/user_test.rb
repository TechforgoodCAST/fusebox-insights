# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @subject = build(:user) }

  test('has many #insights') do
    create_list(:insight, 2, author: @subject)
    assert_equal(2, @subject.insights.size)
  end

  test('has many #proofs') do
    create_list(:proof, 2, author: @subject)
    assert_equal(2, @subject.proofs.size)
  end

  test('has many #unknowns') do
    create_list(:unknown, 2, author: @subject)
    assert_equal(2, @subject.unknowns.size)
  end

  test('has many #in_focus') do
    2.times do
      create(:focus, user: @subject, unknown: build(:unknown, author: @subject))
    end
    assert_equal(2, @subject.in_focus.size)
  end

  test('#username present') { assert_present(:username) }

  test('valid') { assert(@subject.valid?) }
end
