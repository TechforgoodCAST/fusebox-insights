# frozen_string_literal: true

require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase
  setup do
    @creator = create(:user)
    @public_project = create(:project, author: @creator, is_private: false)
    @private_project = create(:project, author: @creator, is_private: true)
  end

  test '#get_membership' do
    @membership = ProjectMember.where(user: @creator, project: @private_project).first
    assert_nil(get_membership(@private_project, @creator))
  end

  test '#private_label true' do
    assert_equal(private_label(@private_project), "Private")
  end

  test '#private_label false' do
    assert_equal(private_label(@public_project), "Public")
  end
end
