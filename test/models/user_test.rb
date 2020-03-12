require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have name, email and password" do
    user = User.new
    user.valid?

    assert_includes user.errors[:name], "can't be blank"
    assert_includes user.errors[:email], "can't be blank"
    assert_includes user.errors[:password], "can't be blank"
  end
end
