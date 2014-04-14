require 'test_helper'

class BeatMissesControllerTest < ActionController::TestCase
  setup do
    @beat_miss = beat_misses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beat_misses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beat_miss" do
    assert_difference('BeatMiss.count') do
      post :create, beat_miss: { beat: @beat_miss.beat, erdate_id: @beat_miss.erdate_id, user_id: @beat_miss.user_id }
    end

    assert_redirected_to beat_miss_path(assigns(:beat_miss))
  end

  test "should show beat_miss" do
    get :show, id: @beat_miss
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beat_miss
    assert_response :success
  end

  test "should update beat_miss" do
    put :update, id: @beat_miss, beat_miss: { beat: @beat_miss.beat, erdate_id: @beat_miss.erdate_id, user_id: @beat_miss.user_id }
    assert_redirected_to beat_miss_path(assigns(:beat_miss))
  end

  test "should destroy beat_miss" do
    assert_difference('BeatMiss.count', -1) do
      delete :destroy, id: @beat_miss
    end

    assert_redirected_to beat_misses_path
  end
end
