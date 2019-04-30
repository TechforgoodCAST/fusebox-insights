# frozen_string_literal: true

require 'application_system_test_case'

class ResponsesTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user)
    @unknown = create(:unknown, author: @user)
    visit project_unknown_path(@project, @unknown)
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

  test 'add insights and comments and check for chronological order' do
    choose 'Insight'
    choose 'More confident'
    fill_in 'Title', with: 'An insight'
    find('trix-editor').click.set('A reason')
    click_on 'Comment'

    choose 'Comment'
    find('trix-editor').click.set('A comment')
    click_on 'Comment'

    choose 'Insight'
    choose 'More confident'
    fill_in 'Title', with: 'Another insight'
    find('trix-editor').click.set('Another reason')
    click_on 'Comment'

    assert_selector('ul li:nth-child(1)', text: 'Insight An insight by CAST contributed 1 confidence less than a minute ago.')
    assert_selector('ul li:nth-child(2)', text: "CAST commented less than a minute ago.\nA comment")
    assert_selector('ul li:nth-child(3)', text: 'Insight Another insight by CAST contributed 1 confidence less than a minute ago.')
  end
end
