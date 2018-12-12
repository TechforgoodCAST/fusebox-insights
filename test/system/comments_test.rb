# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    visit unknown_path(@unknown)
    sign_in
  end

  test 'can comment on unknown' do
    choose 'More confident'
    fill_in 'Title', with: 'A reason'
    click_on 'Comment'

    assert_link 'A reason'
  end
end
