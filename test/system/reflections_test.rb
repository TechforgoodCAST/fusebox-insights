# frozen_string_literal: true

require 'application_system_test_case'

class ReflectionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @project = create(:project, author: @user, users: [@user])
    @assumptions = create_list(:assumption, 2, author: @user, project: @project)
    @assumptions.each do |assumption|
      create(:focus, assumption: assumption, user: @user)
    end

    visit new_user_session_path
    sign_in
  end

  test 'can create reflection' do
    visit_new_reflection_path
    @assumptions.each { |assumption| assert_link assumption.title }
    submit_form(@assumptions)
    assert_text 'Reflections successfully added'
  end

  test 'all fields required' do
    visit_new_reflection_path
    submit_form(@assumptions, title: nil)
    assert_text "can't be blank", count: 2
  end

  test 'duplicate insight title in reflection' do
    insight = create(:insight)
    visit_new_reflection_path
    submit_form(@assumptions, title: insight.title)
    assert_text 'has already been taken'
  end

  def submit_form(assumptions, title: 'Some new insight', confidence: 'More confident')
    assumptions.each_with_index do |_, i|
      fill_in "responses_#{i}_title", with: title
      choose "responses_#{i}_confidence_#{Response::CONFIDENCE[confidence]}"
      find("#responses_#{i}_description").click.set('A reason')
    end
    click_on 'Post Reflections'
  end

  def visit_new_reflection_path
    click_on 'navbarDropdown'
    click_on 'My Focus'
    click_on 'Post Reflections'
  end
end
