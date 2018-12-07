# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup { @subject = build(:comment) }

  test('#confidence present') { assert_present(:confidence) }

  test('#title present') { assert_present(:title) }

  test('#valid? invalid') do
    @subject.title = nil
    refute(@subject.valid?)
  end

  test '#valid? invalid duplicate title' do
    create(:insight, title: 'Title')
    refute(@subject.valid?)
  end

  test('#valid? valid') { assert(@subject.valid?) }

  test '#save valid' do
    assert_equal(0, Insight.count)
    assert_equal(0, Proof.count)
    assert(@subject.save)
    assert_equal(1, Insight.count)
    assert_equal(1, Proof.count)
  end

  test '#save invalid' do
    @subject.title = nil
    refute(@subject.save)
  end
end
