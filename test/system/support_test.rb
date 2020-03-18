# frozen_string_literal: true

require 'application_system_test_case'

class SupportTest < ApplicationSystemTestCase
  setup do
    @topic = build(:topic)
    @cohort = build(:cohort)
    @project = build(:project, cohort: @cohort)
    @contributor = create(:user, projects: [@project])
    @mentor = create(:user, projects: [@project])
    Membership.last.update(role: :mentor)
    @user = create(:user, projects: [@project])
    visit new_user_session_path
    sign_in
  end

  test 'User cannot view support if is not available to their cohort' do
    @offer = build(:offer, topics: [@topic])
    @topic.update(offers: [@offer])

  	# Visit project page
    visit project_path(@project)
    assert_no_link('Get support')

    # Visit topics index
    visit project_topics_path(@project)
    assert_text("Sorry, you don't have access to that")

    # Visit topic page
    visit project_topic_path(@project, @topic)
    assert_text("Sorry, you don't have access to that")

    # Visit offer page
    visit project_offer_path(@project, @offer)
    assert_text("Sorry, you don't have access to that")
  end

  test 'User can view support if is available to their cohort' do
    add_offer_to_cohort

  	# Visit project page
    visit project_path(@project)
    assert_link('Get support')

    # Visit topics index
    visit project_topics_path(@project)
    assert_text('Get help with your project')

    # Visit topic page
    click_on 'Find out more'
    assert_text(@topic.title)
    assert_text(@offer.title)

    # Visit offer page
    click_on 'Find out more'
    assert_text(@offer.title)
  end

  test 'Contributors can book support via email' do
    add_offer_to_cohort

    # Visit offer page
    visit project_offer_path(@project, @offer)
    assert_link('Book your place')

    # Visit booking page
    visit project_offer_book_path(@project, @offer)

    # Submit request
    fill_in :support_request_message, with: 'Test'
    click_on 'Send request'

    assert_text('Support request sent! You should hear back soon.')

    book_support

    mail = ActionMailer::Base.deliveries.last

    assert_equal('New support request', mail.subject)
    assert_includes(mail.to, @offer.provider_email)
    assert_includes(mail.cc, @user.email)
    assert_includes(mail.reply_to, @user.email)
    assert_includes(mail.bcc, @mentor.email)
  end

  test 'Mentors can book support on behalf of others via email' do
    add_offer_to_cohort
    Membership.last.update(role: :mentor)
    book_support

    mail = ActionMailer::Base.deliveries.last

    assert_equal('New support request', mail.subject)
    assert_includes(mail.to, @offer.provider_email)
    assert_includes(mail.cc, @contributor.email)
    assert_includes(mail.reply_to, @contributor.email)
    assert_includes(mail.bcc, @mentor.email)
    assert_includes(mail.bcc, @user.email)
  end

  def book_support
    # Visit offer page
    visit project_offer_path(@project, @offer)
    assert_link('Book your place')

    # Visit booking page
    visit project_offer_book_path(@project, @offer)

    # Submit request
    fill_in :support_request_message, with: 'Test'
    click_on 'Send request'

    assert_text('Support request sent! You should hear back soon.')
  end

  test 'Stakeholders cannot book support' do
    add_offer_to_cohort
    Membership.last.update(role: :stakeholder)

    # Visit offer page
    visit project_offer_path(@project, @offer)
    assert_no_link('Book your place')

    # Visit booking page
    visit project_offer_book_path(@project, @offer)
    assert_text("Sorry, you don't have access to that")
  end

  test 'Contributors and mentors can book support via external booking service' do
    add_offer_to_cohort
    @offer.update(sign_up_link: 'http://www.example.com')

    # Visit offer page
    visit project_offer_path(@project, @offer)
    assert_selector(:css, 'a[href="http://www.example.com"]')
  end

  private

  def add_offer_to_cohort
    @offer = build(:offer, cohorts: [@cohort], topics: [@topic])
    @cohort.update(offers: [@offer])
    @topic.update(offers: [@offer])
  end
end
