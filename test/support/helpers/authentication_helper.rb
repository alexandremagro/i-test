require 'devise/jwt/test_helpers'

module AuthenticationHelper
  def login_as(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end
