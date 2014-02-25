require 'test_helper'

class ErdatesControllerTest < ActionController::TestCase
  setup do
    @erdate = erdates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:erdates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create erdate" do
    assert_difference('Erdate.count') do
      post :create, erdate: { confcall: @erdate.confcall, datetime: @erdate.datetime, estimate: @erdate.estimate, stock_id: @erdate.stock_id, value: @erdate.value }
    end

    assert_redirected_to erdate_path(assigns(:erdate))
  end

  test "should show erdate" do
    get :show, id: @erdate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @erdate
    assert_response :success
  end

  test "should update erdate" do
    put :update, id: @erdate, erdate: { confcall: @erdate.confcall, datetime: @erdate.datetime, estimate: @erdate.estimate, stock_id: @erdate.stock_id, value: @erdate.value }
    assert_redirected_to erdate_path(assigns(:erdate))
  end

  test "should destroy erdate" do
    assert_difference('Erdate.count', -1) do
      delete :destroy, id: @erdate
    end

    assert_redirected_to erdates_path
  end
end
