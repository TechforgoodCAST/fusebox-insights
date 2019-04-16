# frozen_string_literal: true

require 'test_helper'

class SupportMessageTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
    @project = build(:project, author: @user)
    @subject = build(:support_message, project: @project)
    @subject.save
  end

  test 'belongs to #project' do
    assert_kind_of(Project, @subject.project)
  end

  test 'order must be unique for project' do
    @invalid_order_message = SupportMessage.create(status: 'Pending', project: @project, body: 'test', order: 1)
    assert_equal(@invalid_order_message.valid?, false)
  end

  test 'status must be in allowed statuses' do
    @invalid_status_message = SupportMessage.create(status: 'Invalid Status', project: @project, body: 'test', order: 1)
    assert_equal(@invalid_status_message.valid?, false)
  end
end
