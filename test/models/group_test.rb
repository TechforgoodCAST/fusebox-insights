# frozen_string_literal: true

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup { @subject = build(:group) }

  test('belongs to #author') { assert_kind_of(User, @subject.author) }

  test 'has many #unknowns' do
    create_list(:unknown, 2, group: @subject)
    assert_equal(2, @subject.unknowns.size)
  end

  test('#title present') { assert_present(:title) }
  test('#description present') { assert_present(:description) }
  test('#summary present') { assert_present(:summary) }
end
