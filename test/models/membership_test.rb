# frozen_string_literal: true

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  setup do
    @subject = build(:membership)
  end

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end

  test 'belongs to user' do
    assert_instance_of(User, @subject.user)
    assert_present(:user, msg: 'must exist')
  end

  test 'role required' do
    assert_present(:role)
  end

  test 'projects have one membership per user' do
    assert_unique(:project, msg: 'this email has already been added to the project')
  end

  test 'membership uniqueness error mapped to email attribute' do
    assert_unique(:email, msg: 'this email has already been added to the project')
  end

  test '#save_with_user creates new user and membership' do
    @subject.full_name = 'John Doe'
    @subject.email = 'to@example.com'
    @subject.save_with_user
    assert(@subject.persisted?)
  end

  test '#save_with_user finds existing user and creates membership' do
    user = create(:user)
    @subject.email = user.email
    @subject.save_with_user
    assert(@subject.persisted?)
  end

  test '#save_with_user does not save membership if full_name missing' do
    @subject.save_with_user
    assert_error(:full_name, "can't be blank")
  end

  test '#save_with_user does not save membership if email invalid' do
    @subject.save_with_user
    assert_error(:email, "can't be blank")

    @subject.email = 'invalid.com'
    @subject.save_with_user
    assert_error(:email, 'is invalid')
  end
end
