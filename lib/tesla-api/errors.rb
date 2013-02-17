module TeslaAPI
  class InvalidJSON < StandardError
    attr_reader :error

    def initialize(error)
      @error = error
    end

    def to_s
      error.to_s
    end
  end

  class NotLoggedIn < StandardError
  end

  class APIFailure < StandardError
  end

  class InvalidResponse < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def to_s
      "Invalid Response: #{response.inspect}"
    end
  end
end

