module Heimdall
  class App
    module JWTHelper
      def encode(payload)
        secret = ENV['HEIMDALL_SECRET']
        JWT.encode payload, secret, 'HS256'
      end

      def decode(token)
        secret = ENV['HEIMDALL_SECRET']
        begin
          decoded_content = JWT.decode token, secret, true, { :algorithm => 'HS256' }
          return decoded_content.first
        rescue JWT::VerificationError, JWT::DecodeError
          return nil
        end
      end
    end

    helpers JWTHelper
  end
end
