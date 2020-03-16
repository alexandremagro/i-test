class User
  include Mongoid::Document
  include Devise::JWT::RevocationStrategies::Whitelist
  include Deviseable

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
