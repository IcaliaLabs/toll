require "toll/models/authenticable"

module Toll
  module Interface

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def tollify
        before_validation :ensure_authentication_token!

        validates Toll.authentication_token_attribute_name, presence: true,
                                                            uniqueness: true

        include Toll::Models::Authenticable
      end
    end
  end
end
