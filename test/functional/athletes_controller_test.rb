require 'test_helper'

class AthletesControllerTest < ActionController::TestCase
  test "should get journal" do
    get :journal
    assert_response :success
  end

  test "should get performances" do
    get :performances
    assert_response :success
  end

end
