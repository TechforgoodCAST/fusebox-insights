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

  test 'creates add_to_group event on create' do
    @group = create(:group, title: 'test group')
    @unknown = create(:unknown, group: @group)
    assert_equal(1, Event.where(triggerable: @unknown, event_type: 'add_to_group').count)
  end

  test 'no group present does not create add_to_group event' do
    @unknown = create(:unknown)
    assert_equal(Event.where(triggerable: @unknown, event_type: 'add_to_group').any?, false)
  end

  test 'updating with group creates an add_to_group event' do
    @group = create(:group, title: 'test group')
    @unknown = create(:unknown)
    @unknown.group_id = @group.id
    @unknown.save!
    assert_equal(1, Event.where(triggerable: @unknown, event_type: 'add_to_group').count)
  end

end
