class Search
  include Mongoid::Document

  field :tag,         type: String, default: ''
  field :searched_at, type: DateTime

  index({ tag: 1 }, { unique: true })

  validates :tag, presence: true, uniqueness: true
end
