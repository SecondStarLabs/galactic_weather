require 'test_helper'

class MarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mars_index_url
    assert_response :success
  end

end
