require 'test_helper'

class Pages::HelloWorldControllerTest < ActionController::TestCase
  test "should get SayHello" do
    get :SayHello
    assert_response :success
  end

end
