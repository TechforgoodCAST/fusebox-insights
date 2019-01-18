# frozen_string_literal: true

require 'test_helper'

class NotificationsMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
    @user.in_focus << create(:unknown, author: @user)
  end

  test 'weekly_review' do
    mail = NotificationsMailer.weekly_review(@user)
    assert_equal('Your Fusebox status update is due soon', mail.subject)
    assert_equal([@user.email], mail.to)
    assert_equal(['no-reply@fusebox-insights.herokuapp.com'], mail.from)
    assert_match('3 clicks', mail.body.encoded)
    assert_match('/reflections/new', mail.body.encoded)
  end
end
