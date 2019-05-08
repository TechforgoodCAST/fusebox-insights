# frozen_string_literal: true

require 'test_helper'

class AssumptionTest < ActiveSupport::TestCase
  setup { @subject = build(:assumption) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('belongs to #project') { assert_kind_of(Project, @subject.project) }

  test('has many #comments') { assert_has_many(:comments) }

  test('destroys #comments') { assert_destroys(:comments) }

  test('destroys #insights') { assert_destroys(:insights) }

  test 'has many #focussed_by' do
    create(:focus, user: @subject.author, assumption: @subject)
    create(:focus, user: create(:user), assumption: @subject)
    assert_equal(2, @subject.focussed_by.size)
  end

  test 'has many #insights' do
    create_list(:insight, 2, assumption: @subject)
    assert_equal(2, @subject.insights.size)
  end

  test('#title present') { assert_present(:title) }

  test('#title unique to author') { assert_unique(:title) }

  test 'identical #title for different author' do
    @subject.save!
    dup = build(:assumption, title: @subject.title)
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
