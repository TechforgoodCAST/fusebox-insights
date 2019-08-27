# frozen_string_literal: true

require 'application_system_test_case'

class UserTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    visit new_user_session_path
    sign_in
  end

  test 'update account details' do
    assert_nil(@user.display_name)

    click_on 'Account'
    fill_in :user_display_name, with: @user.full_name
    fill_in :user_current_password, with: @user.password
    click_on 'Update'
    @user.reload

    assert_text('Your account has been updated successfully.')
    assert_equal(@user.full_name, @user.display_name)
  end
end
