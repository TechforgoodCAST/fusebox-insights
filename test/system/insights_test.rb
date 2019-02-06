# frozen_string_literal: true

require 'application_system_test_case'

class InsightsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @insight = create(:insight, author: @user)
    @new_insight = build(:insight, author: @user)
    visit insights_url
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'Insights'
  end

  test 'creating a Insight' do
    click_on 'New Insight'

    fill_in 'Title', with: @new_insight.title
    click_on 'Create Insight'

    assert_text 'Insight was successfully created'
  end

  test 'updating a Insight' do
    click_link 'Insights'
    click_on @insight.title
    click_on 'Edit'

    fill_in 'Title', with: @new_insight.title
    click_on 'Update Insight'

    assert_text 'Insight was successfully updated'
  end

  test 'nagivate pagination for more than 10 unknowns' do 
    @insights_list = create_list(:insight, 11, author: @user)
    click_link 'Insights'

    assert_text 'Next'
    click_on '2'

    assert_text 'Prev'
    click_on '1'

    assert_text 'Next'
  end

  test 'limit page to 10 records' do 
    @insights_list = create_list(:insight, 11, author: @user)
    click_link 'Insights'

    assert_selector('div.card', maximum: 10)

    click_on '2'
    assert_selector('div.card', maximum: 10)

  end

  test 'destroying a Insight' do
    click_link 'Insights'
    click_on @insight.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Insight was successfully destroyed'
  end
end
