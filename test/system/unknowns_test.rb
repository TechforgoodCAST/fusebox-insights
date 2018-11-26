# frozen_string_literal: true

require 'application_system_test_case'

class UnknownsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    visit unknowns_url
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'Unknowns'
  end

  test 'creating a Unknown' do
    click_on 'New Unknown'

    fill_in 'Title', with: @unknown.title
    click_on 'Create Unknown'

    assert_text 'Unknown was successfully created'
    click_on 'Back'
  end

  test 'updating a Unknown' do
    click_on 'Edit', match: :first

    fill_in 'Title', with: @unknown.title
    click_on 'Update Unknown'

    assert_text 'Unknown was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Unknown' do
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Unknown was successfully destroyed'
  end
end
