# frozen_string_literal: true

require 'test_helper'

class IterationPolicyTest < ActiveSupport::TestCase
  setup do
    iteration = build(:iteration)
    @membership = create(:membership, project: iteration.project)
    @subject = IterationPolicy.new(@membership.user, iteration)
  end

  test 'contributor can view, create and update iterations' do
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'mentor can view, create and update iterations' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'stakeholder can view iterations' do
    @membership.role = 'stakeholder'
    assert_authorised(%i[show?])
  end

  test 'stakeholder cannot create or update iterations' do
    @membership.update(role: 'stakeholder')
    assert_authorised(%i[new? create? edit? update?], permitted: false)
  end
end
