# frozen_string_literal: true

require 'test_helper'

class InsightTest < ActiveSupport::TestCase
  setup { @subject = build(:insight) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test 'has many #proofs' do
    create_list(:proof, 2, insight: @subject)
    assert_equal(2, @subject.proofs.size)
  end

  test 'destroys #proofs' do
    create(:proof, insight: @subject)
    assert_equal(1, Proof.count)
    @subject.destroy
    assert_equal(0, Proof.count)
  end

  test 'has many #unknowns through #proofs' do
    create_list(:proof, 2, insight: @subject)
    assert_equal(2, @subject.unknowns.size)
  end

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:unknown, title: @subject.title)
    assert(dup.valid?)
  end

  test('valid') { assert(@subject.valid?) }
end
