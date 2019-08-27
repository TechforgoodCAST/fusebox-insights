# frozen_string_literal: true

require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  test 'project_invite' do
    membership = create(:membership)
    mail = NotificationsMailer.project_invite(membership)
    assert_equal("You've been added to a project on Fusebox", mail.subject)
    assert_equal([membership.user.email], mail.to)
    assert_equal(['no-reply@fusebox.org.uk'], mail.from)

    assert_match('contributor', mail.body.encoded)

    assert_match('View project', mail.body.encoded)
    assert_match("/projects/#{membership.project.id}", mail.body.encoded)

    assert_match('reset your password', mail.body.encoded)
    assert_match('/users/password/new', mail.body.encoded)
  end
end
