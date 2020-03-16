require 'test_helper'

class Api::QuotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    stub_request(:get, Const::QUOTES_WEBSITE)
      .to_return(
        status: 200,
        body: file_fixture('quotes.html').read
      )

    @user = User.create!(
      name: 'Luke',
      email: 'luke@rebels.com',
      password: Const::USER_PASSWORD
    )
  end

  # index

  test 'should get quotes by tag to users' do
    headers = login_as @user
    tag = 'quote-odd'

    assert_difference 'Quote.count', 2 do
      get api_quotes_by_tag_path(tag), headers: headers

      quotes = Quote.where(tags: tag)

      assert_response :success
      assert_equal QuoteBlueprint.render_as_json(quotes.to_a, root: 'quotes'),
                   response.parsed_body

    end
  end

  test 'should not get quotes by tag to visitors' do
    tag = 'quote-odd'

    assert_no_difference 'Quote.count' do
      get api_quotes_by_tag_path(tag)

      quotes = Quote.where(tags: tag)

      assert_response :unauthorized
      assert_equal 'You need to sign in or sign up before continuing.',
                   response.parsed_body['message']
    end
  end
end
