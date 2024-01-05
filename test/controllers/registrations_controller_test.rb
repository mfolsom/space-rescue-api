require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    test "user registration with valid data" do
        unique_email = "test_#{Time.now.to_i}@example.com"
        display_name = "Test User"
        assert_difference 'User.count' do
        post user_registration_path, params: { 
            user: {
            email: unique_email,
            password: 'password123',
            password_confirmation: 'password123',
            display_name: display_name
            }
        }
        end
        assert_response :success

        json_response = JSON.parse(response.body)
        assert_equal unique_email, json_response['email']
        assert_equal display_name, json_response['display_name']
        # Assert other attributes if they are included in the response
    end

    test "user registration with invalid data" do
        assert_no_difference 'User.count' do
        post user_registration_path, params: { 
            user: {
            email: '',
            password: 'password123',
            password_confirmation: 'password123',
            display_name: ''
            }
        }
        end
        assert_response :unprocessable_entity
    end
end

