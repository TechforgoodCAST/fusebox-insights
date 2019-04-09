# frozen_string_literal: true

require 'test_helper'

class UnknownTest < ActiveSupport::TestCase
  setup { @subject = build(:unknown) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test 'has many #focussed_by' do
    create(:focus, user: @subject.author, unknown: @subject)
    create(:focus, user: create(:user), unknown: @subject)
    assert_equal(2, @subject.focussed_by.size)
  end

  test 'has many #proofs' do
    create_list(:proof, 2, unknown: @subject)
    assert_equal(2, @subject.proofs.size)
  end

  test 'destroys #proofs' do
    create(:proof, unknown: @subject)
    assert_equal(1, Proof.count)
    @subject.destroy
    assert_equal(0, Proof.count)
  end

  test 'has many #insights through #proofs' do
    create_list(:proof, 2, unknown: @subject)
    assert_equal(2, @subject.insights.size)
  end

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:unknown, title: @subject.title)
    assert(dup.valid?)
  end

  test('valid') { assert(@subject.valid?) }

  test 'creates create event' do
    @subject.save!
    assert_equal(true, @subject.events.where("event_type='create'").present?)
  end

  test 'creates update event' do
    @subject.save!
    @subject.title = 'test'
    @subject.save!
    assert_equal(true, @subject.events.where("event_type='update'").present?)
  end

  test 'creates destroy event' do
    @subject.destroy
    assert_equal(true, Event.where("event_type='destroy'").present?)
  end
end
