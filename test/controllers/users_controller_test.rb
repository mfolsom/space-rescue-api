require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_one = users(:one)
    sign_in @user_one # Devise helper to sign in a user
  end

  test "index should list users" do
    get users_url
    assert_response :success
    users = JSON.parse(response.body)
    assert users.any? { |u| u['email'] == @user_one.email }
  end

  test "show should return user details" do
    get user_url(@user_one)
    assert_response :success
    user = JSON.parse(response.body)
    assert_equal @user_one.email, user['email']
    assert_equal @user_one.display_name, user['display_name']
    assert_equal @user_one.credits, user['credits']
    assert_equal @user_one.level, user['level']
  end

  test "update should modify user details" do
    updated_credits = @user_one.credits + 100
    patch user_url(@user_one), params: { user: { credits: updated_credits } }
    assert_response :success
    @user_one.reload
    assert_equal updated_credits, @user_one.credits
  end

  test "should not update with invalid data" do
    patch user_url(@user_one), params: { user: { email: '' } }
    assert_response :unprocessable_entity
    @user_one.reload
    assert_not_equal '', @user_one.email
  end
end

