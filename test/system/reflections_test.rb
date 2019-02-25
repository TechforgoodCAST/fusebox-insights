# frozen_string_literal: true

require 'application_system_test_case'

class ReflectionsTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @unknowns = create_list(:unknown, 2, author: @user)
    @unknowns.each { |unknown| create(:focus, unknown: unknown, user: @user) }
    visit new_reflection_path
    sign_in
  end

  test 'can create reflection' do
    @unknowns.each { |unknown| assert_link unknown.title }
    submit_form(@unknowns)
    assert_text 'Reflections successfully added'
  end

  test 'all fields required' do
    submit_form(@unknowns, title: nil)
    click_on 'Submit reflection'
    assert_text "can't be blank", count: 2
  end

  test 'duplicate insight title in reflection' do
    insight = create(:insight)
    submit_form(@unknowns, title: insight.title)
    assert_text 'has already been taken'
  end

  def submit_form(unknowns, title: 'Some new insight', confidence: 'More confident')
    unknowns.each_with_index do |u, i|
      fill_in "responses_#{i}_title", with: title
      choose "responses_#{i}_confidence_#{Response::CONFIDENCE[confidence]}"
    end
    click_on 'Submit reflection'
  end
end
