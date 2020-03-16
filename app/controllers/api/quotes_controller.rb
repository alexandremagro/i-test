class Api::QuotesController < ApplicationController
  before_action :authenticate_user!
  before_action :read_quotes, only: :index

  def index
    @quotes = Quote.where(tags: params[:tag])

    render json: QuoteBlueprint.render(@quotes.to_a, root: :quotes)
  end

  private

  def read_quotes
    return if Search.where(tag: params[:tag]).exists?

    QuotesToScrapReader.call(params[:tag])
    Search.create(tag: params[:tag], searched_at: Time.zone.now)
  end
end
