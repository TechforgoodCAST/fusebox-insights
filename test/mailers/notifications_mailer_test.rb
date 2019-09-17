# frozen_string_literal: true

require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  test '#project_invite' do
    membership = create(:membership)
    mail = NotificationsMailer.project_invite(membership)
    assert_equal("You've been added to a project on Fusebox", mail.subject)
    assert_equal([membership.user.email], mail.to)
    assert_equal(['no-reply@fusebox.org.uk'], mail.from)

    assert_match('contributor', mail.body.encoded)

    assert_match('View project', mail.body.encoded)
    assert_match("/projects/#{membership.project_id}", mail.body.encoded)

    assert_match('reset your password', mail.body.encoded)
    assert_match('/users/password/new', mail.body.encoded)
  end

  test '#check_in_due' do
    assert_reminder_email(:check_in_due, 'Check-in due', 'check_in')
  end

  test '#check_in_overdue' do
    assert_reminder_email(:check_in_overdue, 'Check-in overdue!', 'check_in')
  end
  
  test '#debrief_due' do
    assert_reminder_email(:debrief_due, 'Debrief due', 'debrief')
  end

  test '#debrief_overdue' do
    assert_reminder_email(:debrief_overdue, 'Debrief overdue!', 'debrief')
  end

  private

  def assert_reminder_email(method, subject, type)
    iteration = create(:iteration)
    contributor = create(:membership, role: :contributor, project: iteration.project)
    mentor = create(:membership, role: :mentor, project: iteration.project)
    mail = NotificationsMailer.send(method, iteration)

    assert_equal(subject, mail.subject)
    assert_equal([contributor.user.email, mentor.user.email], mail.to)
    assert_match(
      "/projects/#{iteration.project_id}/iterations/#{iteration.id}/#{type}s/new",
      mail.body.encoded
    )
  end
end
