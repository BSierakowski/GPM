require 'test_helper'

class GpmSearchesControllerTest < ActionController::TestCase
  setup do
    @gpm_search = gpm_searches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gpm_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gpm_search" do
    assert_difference('GpmSearch.count') do
      post :create, gpm_search: {  }
    end

    assert_redirected_to gpm_search_path(assigns(:gpm_search))
  end

  test "should show gpm_search" do
    get :show, id: @gpm_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gpm_search
    assert_response :success
  end

  test "should update gpm_search" do
    patch :update, id: @gpm_search, gpm_search: {  }
    assert_redirected_to gpm_search_path(assigns(:gpm_search))
  end

  test "should destroy gpm_search" do
    assert_difference('GpmSearch.count', -1) do
      delete :destroy, id: @gpm_search
    end

    assert_redirected_to gpm_searches_path
  end
end
