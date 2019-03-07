# frozen_string_literal: true

require 'application_system_test_case'

class ResponsesTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    visit unknown_path(@unknown)
    sign_in
  end

  test 'can add insight to unknown' do
    choose 'Insight'
    choose 'More confident'
    fill_in 'Title', with: 'An insight'
    find('trix-editor').click.set('A reason')
    click_on 'Comment'

    assert_link 'An insight'
  end

  test 'can add comment to unknown' do
    choose 'Comment'
    find('trix-editor').click.set('A comment')
    click_on 'Comment'

    assert_text 'A comment'
  end
end
