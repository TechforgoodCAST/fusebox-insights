# frozen_string_literal: true

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup { @subject = build(:group) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test('belongs to #project') { assert_kind_of(Project, @subject.project) }

  test('has many #assumptions') { assert_has_many(:assumptions) }

  test('#title present') { assert_present(:title) }

  test('#title unique to project') { assert_unique(:title) }
end
