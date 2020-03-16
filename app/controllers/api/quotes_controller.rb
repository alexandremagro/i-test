class Api::QuotesController < ApplicationController
  before_action :authenticate_user!
  before_action :read_quotes, only: :index

  def index
    @quotes = Quote.where(tags: params[:tag])

    render json: QuoteBlueprint.render(@quotes.to_a, root: :quotes)
  end

  private

  def read_quotes
    QuotesToScrapReader.call(params[:tag])
  end
end
