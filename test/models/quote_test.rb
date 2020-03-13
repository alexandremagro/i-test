require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test 'should have quote' do
    quote = Quote.new
    quote.valid?

    assert_includes quote.errors[:quote], "can't be blank"
  end
end
