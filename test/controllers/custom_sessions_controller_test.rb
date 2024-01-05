require "test_helper"

class CustomSessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @user = users(:one) # Ensure this user has a valid email and password in your fixtures
    end

    test "user login with correct credentials" do
        post user_session_path, params: {
        user: {
            email: @user.email,
            password: 'password123' # Ensure this matches the password in your fixtures
        }
        }
        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal @user.email, json_response['email']
        assert_equal @user.credits, json_response['credits']
        assert_equal @user.level, json_response['level']
        assert_equal @user.saved_game_state, json_response['saved_game_state']
        assert_equal @user.display_name, json_response['display_name']
    end

    test "user login with incorrect credentials" do
    post user_session_path, params: {
        user: {
        email: @user.email,
        password: 'wrongpassword'
        }
    }
    assert_response :unauthorized
    json_response = JSON.parse(response.body)
    assert_equal 'Invalid credentials', json_response['error']
    end
end
