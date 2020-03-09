# frozen_string_literal: true

require 'application_system_test_case'

class OffersTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    visit new_user_session_path
    sign_in
  end

  test 'Any signed in user can navigate to offer page'
  test 'Contributors and mentors can book support via external booking service'
  test 'Contributors and mentors can book support via email'
end
