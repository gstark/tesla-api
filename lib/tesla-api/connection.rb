module TeslaAPI
  # Connection object to the Tesla Model S HTTP API endpoint.
  class Connection
    include PrivateAPI

    # email address of logged in user
    attr_reader :email

    # password of logged in user
    attr_reader :password

    # Host for status/command related API
    HOST = "https://portal.vn.teslamotors.com"

    # Host for streaming API
    STREAMING_HOST = "https://streaming.vn.teslamotors.com"

    # Supply the email and password for login to teslamotors.com
    def initialize(email, password)
      @email    = email
      @password = password

      @client = HTTPClient.new
      @client.set_cookie_store("cookie.dat")

      login(email, password)
    end

    # Call to see all HTTP traffic to and from the API
    def debug!
      @client.debug_dev = STDOUT
    end

    # Convenience method to return the first Vehicle
    def vehicle
      vehicles.first
    end

    # Returns Vehicle objects for all vehicles the account contains
    def vehicles
      @vehicles ||= begin
        _, json = get_json("/vehicles")
        json.map { |data| Vehicle.new(self, data) }
      end
    end

    # Force the vehicles to reload (in case some of the data has changed)
    def reload!
      @vehicles = nil
    end

    # Logged into the API
    def logged_in?
      @logged_in
    end
  end
end

