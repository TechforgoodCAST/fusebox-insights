# frozen_string_literal: true

require 'application_system_test_case'

class FociTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    visit root_path
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'In focus'
  end

  test 'change focus' do
    click_on 'Change focus'

    select(@unknown.title)
    click_on 'Update User'

    assert_text 'Focus successfully updated.'
    assert_text @unknown.title
  end
end
