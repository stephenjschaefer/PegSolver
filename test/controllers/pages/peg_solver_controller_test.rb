require 'test_helper'

class Pages::PegSolverControllerTest < ActionController::TestCase
  test "should get DrawBoard" do
    get :DrawBoard
    assert_response :success
  end

  test "should get Solve" do
    get :Solve
    assert_response :success
  end

end
