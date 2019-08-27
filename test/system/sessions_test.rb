# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    visit new_user_session_path
  end

  test 'sign in' do
    sign_in

    assert_text('Signed in successfully')
  end

  test 'sign out' do
    sign_in
    click_on 'Sign out'

    assert_text('Signed out successfully')
  end

  test 'valid reset password' do
    request_password_reset(@user.email)
    mail = ActionMailer::Base.deliveries.last

    assert_equal(@user.email, mail.to[0])
    assert_equal('Reset password instructions', mail.subject)
  end

  test 'invalid reset password' do
    request_password_reset('missing@email.com')

    assert_empty(ActionMailer::Base.deliveries)
  end

  private

  def request_password_reset(email)
    click_on 'Forgot Your Password'
    fill_in :user_email, with: email
    click_on 'Send reset instructions'
  end
end
