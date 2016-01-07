require 'test_helper'

class BoardsControllersControllerTest < ActionController::TestCase
  setup do
    @boards_controller = boards_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boards_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boards_controller" do
    assert_difference('BoardsController.count') do
      post :create, boards_controller: {  }
    end

    assert_redirected_to boards_controller_path(assigns(:boards_controller))
  end

  test "should show boards_controller" do
    get :show, id: @boards_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boards_controller
    assert_response :success
  end

  test "should update boards_controller" do
    patch :update, id: @boards_controller, boards_controller: {  }
    assert_redirected_to boards_controller_path(assigns(:boards_controller))
  end

  test "should destroy boards_controller" do
    assert_difference('BoardsController.count', -1) do
      delete :destroy, id: @boards_controller
    end

    assert_redirected_to boards_controllers_path
  end
end
