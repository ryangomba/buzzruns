require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get athletes" do
    get :athletes
    assert_response :success
  end

  test "should get milage" do
    get :milage
    assert_response :success
  end

  test "should get performances" do
    get :performances
    assert_response :success
  end

end
