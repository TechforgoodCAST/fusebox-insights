require 'application_system_test_case'

class SupportMessageTest < ApplicationSystemTestCase

  setup do
    @staff_user = create(:user, is_staff: true)
    @non_staff_user = create(:user)
    @project = create(:project)
    @subject = create(:support_message, project: @project)
    visit support_messages_path(slug: @subject.project.slug)
    sign_in(@staff_user)
  end

  test 'show index page' do
    assert_selector 'h1', text: 'Support Messages for project: ' + @subject.project.name
  end

  test 'create support message' do
    click_on 'Add another'
    fill_in 'support_message_order', with: 2
    click_on 'Create Support message'
    assert_text 'Support message created successfully.'
  end

  test 'edit support message' do
    first('.edit-link').click
    fill_in 'support_message_order', with: 3
    click_on 'Update Support message'
    assert_text 'Support message updated successfully.'
  end

  test 'destroy support message' do
    first('.destroy-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text 'Support message destroyed successfully.'
  end

  test 'non_staff_user cannot add message' do
    sign_out
    visit new_user_session_path
    sign_in(@non_staff_user)
    visit support_messages_path(slug: @subject.project.slug)
    click_on 'Add another'
    assert_text "Sorry, you don't have access to that"
  end

  test 'non_staff_user cannot edit' do
    sign_out
    visit new_user_session_path
    sign_in(@non_staff_user)
    visit support_messages_path(slug: @subject.project.slug)
    first('.edit-link').click
    assert_text "Sorry, you don't have access to that"
  end

  test 'non_staff_user cannot delete' do
    sign_out
    visit new_user_session_path
    sign_in(@non_staff_user)
    visit support_messages_path(slug: @subject.project.slug)
    first('.destroy-link').click
    page.driver.browser.switch_to.alert.accept
    assert_text "Sorry, you don't have access to that"
  end

end
