# frozen_string_literal: true

require 'test_helper'

class MilestonePolicyTest < ActiveSupport::TestCase
  setup do
    milestone = build(:milestone)
    @membership = create(:membership, project: milestone.project)
    @subject = MilestonePolicy.new(@membership.user, milestone)
  end

  test 'contributor can view, create and update milestones' do
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'mentor can view, create and update milestones' do
    @membership.role = 'mentor'
    assert_authorised(%i[show? new? create? edit? update?])
  end

  test 'stakeholder can view milestones' do
    @membership.role = 'stakeholder'
    assert_authorised(%i[show?])
  end

  test 'stakeholder cannot create or update milestones' do
    @membership.update(role: 'stakeholder')
    assert_authorised(%i[new? create? edit? update?], permitted: false)
  end
end
