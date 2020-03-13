module Deviseable
  extend ActiveSupport::Concern

  module ClassMethods
    # NOTE: Needed in Sessions#destroy
    def primary_key
      '_id'
    end
  end
end
