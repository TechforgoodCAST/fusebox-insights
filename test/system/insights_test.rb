# frozen_string_literal: true

require 'application_system_test_case'

class InsightsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @insight = create(:insight, author: @user)
    @new_insight = build(:insight, author: @user)

    @other_user = create(:user)
    @others_insight = create(:insight, author: @other_user)

    @project = create(:project, author: @user)

    visit project_insights_path(@project)
    sign_in(@user)
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'Insights'
  end

  test 'updating a Insight' do
    visit project_insights_path(@project)
    click_on @insight.title
    click_on 'Edit'

    fill_in 'Title', with: @new_insight.title
    click_on 'Update Insight'

    assert_text 'Insight was successfully updated'
  end

  test 'nagivate pagination for more than 10 insights' do
    @insights_list = create_list(:insight, 11, author: @user)
    visit project_insights_path(@project)

    assert_text 'Next'
    click_on 'Next'

    assert_text 'Prev'
    click_on 'Prev'

    assert_text 'Next'
  end

  test 'limit page to 10 records' do
    @insights_list = create_list(:insight, 11, author: @user)
    visit project_insights_path(@project)

    assert_selector('div.card', maximum: 10)

    click_on '2'
    assert_selector('div.card', maximum: 10)
  end

  test 'destroying a Insight' do
    visit project_insights_path(@project)
    click_on @insight.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Insight was successfully destroyed'
  end

  test 'cant edit or delete a different users insight' do
    visit project_insights_path(@project)
    click_on @others_insight.title

    assert_no_text 'Edit'
    assert_no_text 'Delete'
  end

  test 'can edit and delete your own insight' do
    visit project_insights_path(@project)
    click_on @insight.title

    assert_text 'Edit'
    assert_text 'Delete'
  end

  test 'cannot visit unknown path if not author' do
    visit edit_project_insight_path(@project, @others_insight)
    assert_equal('/', current_path)
  end

  test 'can visit insight path if author' do
    visit edit_project_insight_path(@project, @insight)
    assert_equal(edit_project_insight_path(@project, @insight), current_path)
  end
end
