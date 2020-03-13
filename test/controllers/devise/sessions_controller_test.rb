require 'test_helper'

class Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      name: 'Luke',
      email: 'luke@rebels.com',
      password: Const::USER_PASSWORD
    )
    @visitor = User.new(
      name: 'Chewbacca',
      email: 'chewbacca@rebels.com',
      password: Const::USER_PASSWORD
    )
  end

  # create

  test 'should create' do
    assert_difference 'WhitelistedJwt.count' do
      post session_path, params: {
        user: {
          email: @user.email,
          password: @user.password
        }
      }

      assert_response :success
      assert_equal response.parsed_body, @user.as_json
      assert response.headers['Authorization'].present?
    end
  end

  test 'should not create for wrong password' do
    assert_no_difference 'WhitelistedJwt.count' do
      post session_path, params: {
        user: {
          email: @user.email,
          password: @user.password.reverse
        }
      }

      assert_response :unauthorized
      assert_equal response.parsed_body['type'], 'invalid'
    end
  end

  test 'should not create for an unregistered email' do
    assert_no_difference 'WhitelistedJwt.count' do
      post session_path, params: {
        user: {
          email: @visitor.email,
          password: @visitor.password
        }
      }

      assert_response :unauthorized
      assert_equal response.parsed_body['type'], 'not_found_in_database'
    end
  end

  # destroy

  test 'should destroy' do
    headers = login_as @user

    assert_difference 'WhitelistedJwt.count', -1 do
      delete session_path, headers: headers

      assert_response :success
    end
  end
end
