require 'test_helper'

class Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
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
    assert_difference 'User.count' do
      assert_difference 'WhitelistedJwt.count' do
        post registration_path, params: {
          user: {
            name: @visitor.name,
            email: @visitor.email,
            password: @visitor.password
          }
        }

        assert_response :success
        assert_equal response.parsed_body.except('_id'),
                     @visitor.as_json.except('_id')
        assert response.headers['Authorization'].present?
      end
    end
  end

  test 'should not create with an already registered email' do
    assert_no_difference 'User.count' do
      assert_no_difference 'WhitelistedJwt.count' do
        post registration_path, params: {
          user: {
            name: @user.name,
            email: @user.email,
            password: @user.password
          }
        }

        assert_response :unprocessable_entity
      end
    end
  end
end
