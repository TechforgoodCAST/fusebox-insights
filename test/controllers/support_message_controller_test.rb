require 'test_helper'

class SupportMessageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get support_message_index_url
    assert_response :success
  end

end
