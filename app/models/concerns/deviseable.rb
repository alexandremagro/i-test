module Deviseable
  extend ActiveSupport::Concern

  included do
    # Rewrite function to Mongoid compatibility
    def self.jwt_revoked?(payload, user)
      !user.whitelisted_jwts.where(payload.slice('jti', 'aud')).exists?
    end
  end

  module ClassMethods
    # NOTE: Needed in Sessions#destroy
    def primary_key
      '_id'
    end
  end
end
