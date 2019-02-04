# frozen_string_literal: true

require 'application_system_test_case'

class UnknownsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknown = create(:unknown, author: @user)
    @new_unknown = build(:unknown, author: @user)

    @other_user = create(:user)
    @others_unknown = create(:unknown, author: @other_user)

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

  test 'destroying a Unknown' do
    click_link 'Unknowns'
    click_on @unknown.title

    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Unknown was successfully destroyed'
  end

  test 'cant edit or delete a different users unknown' do
    click_link 'Unknowns'
    click_on @others_unknown.title

    assert_no_text 'Edit'
    assert_no_text 'Delete'
  end

  test 'can edit and delete your own unknown' do
    click_link 'Unknowns'
    click_on @unknown.title

    assert_text 'Edit'
    assert_text 'Delete'

  end

  test 'cannot visit unknown path if not author' do
    visit edit_unknown_path(@others_unknown)
    assert_equal('/', current_path)

  end

  test 'can visit unknown path if author' do    
    visit edit_unknown_path(@unknown)
    assert_equal(edit_unknown_path(@unknown), current_path)

  end
end