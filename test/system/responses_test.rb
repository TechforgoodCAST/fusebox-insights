# frozen_string_literal: true

require 'application_system_test_case'

class ResponsesTest < ApplicationSystemTestCase
  setup do
    # TODO: DRY
    @user = create(:user)
    @project = create(:project, author: @user, users: [@user])
    @assumption = create(:assumption, author: @user, project: @project)

    visit new_user_session_path
    sign_in
    visit project_assumption_path(@project, @assumption)
  end

  test 'visitor cannot post on an assumption' do
    sign_out
    visit project_assumption_path(@project, @assumption)
    assert_no_button 'Post'
  end

  test 'member can add insight to assumption' do
    choose 'Insight'
    select 'More confident'
    fill_in 'Title', with: 'An new insight'
    find('#response_description').click.set('A reason')
    click_on 'Post'

    assert_text 'An new insight'
  end

  test 'member can add comment to assumption' do
    choose 'Comment'
    find('#response_description').click.set('My new comment')
    click_on 'Post'

    assert_text 'My new comment'
  end
end
