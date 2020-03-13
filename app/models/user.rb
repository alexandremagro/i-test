class User
  include Deviseable
  include Mongoid::Document
  include Devise::JWT::RevocationStrategies::Whitelist

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''
  field :name,               type: String

  validates :name, presence: true
end
