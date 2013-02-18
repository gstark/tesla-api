module TeslaAPI
  # Exceptions thrown by the TeslaAPI
  module Errors
    # JSON cannot be parsed
    class InvalidJSON < StandardError
      # JSON parsing error details
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_s
        error.to_s
      end
    end

    # Thrown when the action requires a logged in connection
    class NotLoggedIn < StandardError
    end

    # Thrown when the API returns a failure state
    class APIFailure < StandardError
    end

    # Thrown when the response is invalid (non 200-OK HTTP result)
    class InvalidResponse < StandardError
      # Response object from httpclient
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        "Invalid Response: #{response.inspect}"
      end
    end
  end
end

