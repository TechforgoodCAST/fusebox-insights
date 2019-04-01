# frozen_string_literal: true

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup { @subject = build(:group) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('belongs to #project') { assert_kind_of(Project, @subject.project) }

  test('can exist without a #project') do
    @subject.project = nil
    assert(@subject.valid?)
  end

  test 'has many #unknowns' do
    create_list(:unknown, 2, group: @subject)
    assert_equal(2, @subject.unknowns.size)
  end

  test('#title present') { assert_present(:title) }
end
