class Quote
  include Mongoid::Document

  field :quote, type: String, default: ''
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array, default: []

  validates :quote, presence: true
end
