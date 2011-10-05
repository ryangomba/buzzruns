require 'test_helper'

class PerformancesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get calendar" do
    get :calendar
    assert_response :success
  end

  test "should get year" do
    get :year
    assert_response :success
  end

  test "should get season" do
    get :season
    assert_response :success
  end

end
