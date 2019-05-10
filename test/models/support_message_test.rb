# frozen_string_literal: true

require 'test_helper'

class SupportMessageTest < ActiveSupport::TestCase
  setup do
    @subject = create(:support_message)
  end

  test 'belongs to #project' do
    assert_kind_of(Project, @subject.project)
  end

  test 'order must be unique for project' do
    dup = @subject.dup
    dup.valid?
    assert_error(:order, 'has already been taken', subject: dup)
  end

  test 'status must be in allowed statuses' do
    @subject.status = 'Invalid Status'
    @subject.valid?
    assert_error(:status, 'is not included in the list')
  end
end
