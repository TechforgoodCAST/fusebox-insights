# frozen_string_literal: true

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup { @subject = build(:group) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('belongs to #project') { assert_kind_of(Project, @subject.project) }

  test 'has many #assumptions' do
    create_list(:assumption, 2, group: @subject)
    assert_equal(2, @subject.assumptions.size)
  end

  test('#title present') { assert_present(:title) }
end
