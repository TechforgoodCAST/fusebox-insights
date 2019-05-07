# frozen_string_literal: true

require 'application_system_test_case'

class FociTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @assumption = create(:unknown, author: @user)
    visit new_user_session_path
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'In focus'
  end

  test 'change focus' do
    click_on 'Change focus'

    select(@assumption.title)
    click_on 'Change focus'

    assert_text 'Focus successfully updated.'
    assert_text @assumption.title
  end
end
