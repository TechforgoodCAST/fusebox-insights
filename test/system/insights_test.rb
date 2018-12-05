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
    click_on 'Back'
  end

  test 'updating a Insight' do
    click_on 'Edit', match: :first

    fill_in 'Title', with: @new_insight.title
    click_on 'Update Insight'

    assert_text 'Insight was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Insight' do
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Insight was successfully destroyed'
  end
end
