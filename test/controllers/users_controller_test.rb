require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
test "should get create with valid data" do
  assert_difference('User.count') do
    post users_url, params: { user: { username: 'test', password: 'test', credits: 0, level: 1, saved_game_state: '' } }
  end
  assert_response :created
  json_response = JSON.parse(response.body)
  assert_equal 'test', json_response['username']
end

test "should not create user with invalid data" do
  assert_no_difference('User.count') do
    post users_url, params: { user: { username: '', password: 'test', credits: 0, level: 1, saved_game_state: '' } }
  end
  assert_response :unprocessable_entity
end


end
