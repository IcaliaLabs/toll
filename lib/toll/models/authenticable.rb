module Toll
  module Models
    module Authenticable

      # Updates the record authentication but:
      #
      # - Validation is skipped.
      # - Callbacks are invoked.
      # - updated_at/updated_on column is updated if that column is available.
      # - Updates all the attributes that are dirty in this object.
      #
      def update_authentication_token_without_validations
        generate_authentication_token!
        update_attribute(Toll.authentication_token_attribute_name, self.send(Toll.authentication_token_attribute_name))
      end

      # Updates the record but:
      #
      # - Validations are skipped.
      # - Callbacks are skipped.
      # - updated_at/updated_on are not updated.
      def update_authentication_token!
        generate_authentication_token!
        update_column(Toll.authentication_token_attribute_name, self.send(Toll.authentication_token_attribute_name))
      end

      # Method to authenticate the user
      # It only updates the token
      #
      # We are making sure the user is a valid record, that's why
      # the `save` call
      def authenticate_with_token
        generate_authentication_token!
        save
        self
      end

      # Not really convinced about the sign_out method name
      alias_method :sign_out, :authenticate_with_token

      private

        def generate_authentication_token!
          begin
            self.send("#{Toll.authentication_token_attribute_name}=", Toll.token)
          end while self.class.exists?(Toll.authentication_token_attribute_name => self.send(Toll.authentication_token_attribute_name))
        end

        def ensure_authentication_token!
          generate_authentication_token!
        end

    end
  end
end
