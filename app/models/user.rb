class User
  include Mongoid::Document

  devise :database_authenticatable,
         :registerable,
         :validatable

  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''
  field :name,               type: String

  validates :name, presence: true
end
