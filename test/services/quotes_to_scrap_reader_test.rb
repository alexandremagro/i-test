require 'test_helper'

class QuotesToScrapReaderTest < ActiveSupport::TestCase
  def setup
    stub_request(:get, Const::QUOTES_WEBSITE)
      .to_return(
        status: 200,
        body: file_fixture('quotes.html').read
      )
  end

  # call

  test 'should save quotes data' do
    assert_difference 'Quote.count', 2 do
      QuotesToScrapReader.call('quote-odd') # [1, 3]

      first = Quote.first

      assert_equal 'Quote one', first.quote
      assert_equal 'Quote One Author', first.author
      assert_equal '/author/Quote-One-Author', first.author_about
      assert_equal %w[quote-1 quote-odd], first.tags

      second = Quote.last

      assert_equal 'Quote three', second.quote
      assert_equal 'Quote Three Author', second.author
      assert_equal '/author/Quote-Three-Author', second.author_about
      assert_equal %w[quote-3 quote-odd], second.tags
    end
  end
end
