# frozen_string_literal: true

require 'test_helper'

class CheckInPolicyTest < ActiveSupport::TestCase
  setup do
    check_in = build(:check_in)
    @membership = create(:membership, project: check_in.iteration.project)
    @subject = CheckInPolicy.new(@membership.user, check_in)
  end

  test 'contributor can view, create and update check-ins' do
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'mentor can view, create and update check-ins' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'stakeholder cannot view, create or update check-ins' do
    @membership.update(role: 'stakeholder')
    assert_authorised(%i[show? new? create? edit? update?], permitted: false)
  end
end
