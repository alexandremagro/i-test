require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test 'should have tag' do
    search = Search.new
    search.valid?

    assert_includes search.errors[:tag], "can't be blank"
  end
end
