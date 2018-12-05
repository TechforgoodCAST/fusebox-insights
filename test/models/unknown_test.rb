# frozen_string_literal: true

require 'test_helper'

class UnknownTest < ActiveSupport::TestCase
  setup { @subject = build(:unknown, author: build(:user)) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('has many #focussed_by') do
    create(:focus, user: @subject.author, unknown: @subject)
    create(:focus, user: create(:user), unknown: @subject)
    assert_equal(2, @subject.focussed_by.size)
  end

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:unknown, title: @subject.title, author: build(:user))
    assert(dup.valid?)
  end

  test('valid') { assert(@subject.valid?) }
end
