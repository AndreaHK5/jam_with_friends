require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get edit_profile" do
    get :edit_profile
    assert_response :success
  end

end
