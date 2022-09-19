class Api::V1::UsersControllerTest < ActionController::TestCase

  test "it should create a new user" do
    new_user = users(:one)
    assert_response :success
  end

  test "it should return user credentials" do
    user = users(:two)
    assert_response :success
  end

end
