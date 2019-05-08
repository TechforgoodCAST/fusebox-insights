# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @subject = build(:user) }

  test('has many #insights') do
    create_list(:insight, 2, author: @subject)
    assert_equal(2, @subject.insights.size)
  end

  test('has many #assumptions') do
    create_list(:assumption, 2, author: @subject)
    assert_equal(2, @subject.assumptions.size)
  end

  test('has many #in_focus') do
    2.times do
      create(:focus, user: @subject, assumption: build(:assumption, author: @subject))
    end
    assert_equal(2, @subject.in_focus.size)
  end

  test('#username present') { assert_present(:username) }

  test('valid') { assert(@subject.valid?) }

  test '#initials' do
    @subject.username = 'John Doe'
    assert_equal('J', @subject.initials)
  end
end
