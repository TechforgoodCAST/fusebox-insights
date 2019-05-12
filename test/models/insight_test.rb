# frozen_string_literal: true

require 'test_helper'

class InsightTest < ActiveSupport::TestCase
  setup { @subject = build(:insight) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test 'can belong to #assumption' do
    @subject.assumption = build(:assumption)
    assert_kind_of(Assumption, @subject.assumption)
  end

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:assumption, title: @subject.title)
    assert(dup.valid?)
  end

  test('valid') { assert(@subject.valid?) }
end
