require 'nokogiri'
require 'open-uri'

class QuotesToScrapReader < ApplicationService
  def initialize(tag)
    @tag = tag
  end

  def call
    doc = Nokogiri::HTML(open(Const::QUOTES_WEBSITE))

    # Prefer use `where().pluck()` (1 + N queries)
    # instead `find_or_create_by` (N * 2 queries)
    stored_quotes = Quote.where(tags: @tag).pluck(:quote)

    doc
      .css("body .quote .tag:contains('#{@tag}')")
      .each do |node|
        quote = node.ancestors('.quote')
        text = quote.css('.text').text

        next if stored_quotes.include?(text)

        Quote.create quote: text,
                     author: quote.css('.author').text,
                     author_about: quote.css('.author + a')[0]['href'],
                     tags: quote.css('.tags .tag').map(&:text)
      end
  end
end
