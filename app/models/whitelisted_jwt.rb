class WhitelistedJwt
  include Mongoid::Document

  belongs_to :user

  field :jti, type: String
  field :aud, type: String
  field :exp, type: DateTime

  validates :jti, presence: true

  index({ jti: 1 }, { unique: true })
end
