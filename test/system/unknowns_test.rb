# frozen_string_literal: true

require 'application_system_test_case'

class UnknownsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    @new_unknown = build(:unknown, author: @user)
    visit unknowns_url
    sign_in
  end

  test 'visiting the index' do
    assert_selector 'h1', text: 'Unknowns'
  end

  test 'creating a Unknown' do
    click_on 'New Unknown'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Create Unknown'

    assert_text 'Unknown was successfully created'
  end

  test 'updating a Unknown' do
    click_link 'Unknowns'
    click_on @unknown.title
    click_on 'Edit'

    fill_in 'Title', with: @new_unknown.title
    click_on 'Update Unknown'

    assert_text 'Unknown was successfully updated'
  end

  test 'nagivate pagination for more than 10 unknowns' do 
    @unknowns_list = create_list(:unknown, 11, author: @user)
    click_link 'Unknowns'

    assert_text 'Next'
    click_on '2'

    assert_text 'Prev'
    click_on '1'

    assert_text 'Next'
  end

  test 'limit page to 10 records' do 
    @unknowns_list = create_list(:unknown, 11, author: @user)
    click_link 'Unknowns'

    assert_selector('div.card', maximum: 10)

    click_on '2'
    assert_selector('div.card', maximum: 10)

  end

  test 'destroying a Unknown' do
    click_link 'Unknowns'
    click_on @unknown.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Unknown was successfully destroyed'
  end


end