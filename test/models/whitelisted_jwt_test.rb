require 'test_helper'

class WhitelistedJwtTest < ActiveSupport::TestCase
  test 'should have jti' do
    jwt = WhitelistedJwt.new
    jwt.valid?

    assert_includes jwt.errors[:jti], "can't be blank"
  end
end
