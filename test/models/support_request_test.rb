# frozen_string_literal: true

require 'test_helper'

class SupportRequestTest < ActiveSupport::TestCase
  setup { @subject = build(:support_request) }

  test 'belongs to requester' do
    assert_instance_of(User, @subject.requester)
    assert_present(:requester, msg: 'must exist')
  end

  test 'belongs to offer' do
    assert_instance_of(Offer, @subject.offer)
    assert_present(:offer, msg: 'must exist')
  end

  test 'belongs to project' do
    assert_instance_of(Project, @subject.project)
    assert_present(:project, msg: 'must exist')
  end

  test('requester required') { assert_present(:requester) }

  test('message required') { assert_present(:message) }

  test('offer required') { assert_present(:offer) }

  test('project required') { assert_present(:project) }
end
