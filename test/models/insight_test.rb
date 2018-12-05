# frozen_string_literal: true

require 'test_helper'

class InsightTest < ActiveSupport::TestCase
  setup { @subject = build(:insight, author: build(:user)) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:unknown, title: @subject.title, author: build(:user))
    assert(dup.valid?)
  end

  test('valid') { assert(@subject.valid?) }
end
