module Toll
  module Controllers
    module Authenticable

      protected

      def authenticate!
        authenticate_with_token || render_unauthorized
      end

      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: { errors: "Invalid session data" },
          status: :unauthorized
      end

      def authenticate_with_token
        authenticate_with_http_token do |token, options|

          user = User.find_by(authentication_keys(options))

          if user && secure_token_compare(user.send(Toll.authentication_token_attribute_name), token)
            @current_user = user
          end
        end
      end

      def current_user
        @current_user
      end

      private

      # constant-time comparison algorithm to prevent timing attacks
      # Thanks Devise
      def secure_token_compare(a, b)
        return false if a.blank? || b.blank? || a.bytesize != b.bytesize
        l = a.unpack "C#{a.bytesize}"

        res = 0
        b.each_byte { |byte| res |= byte ^ l.shift }
        res == 0
      end

      def authentication_keys(options = {})
        {}.tap do |authentication_keys|
          Toll.authentication_keys.each do |key|
            authentication_keys[key] = options[key]
          end
        end
      end
    end
  end
end

