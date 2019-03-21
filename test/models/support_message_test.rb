require 'test_helper'

class SupportMessageTest < ActiveSupport::TestCase
  
  setup do
    @user = build(:user)
    @project = Project.create(name: 'test', slug: 'test', user: @user)
    @project.save
    @subject = SupportMessage.create(status: 'Pending', project: @project, body: 'test', order: 1)
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
