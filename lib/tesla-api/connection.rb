module TeslaAPI
  class Connection
    include PrivateAPI

    attr_reader :email, :password

    HOST           = "https://portal.vn.teslamotors.com"
    STREAMING_HOST = "https://streaming.vn.teslamotors.com"

    def initialize(email, password)
      @email    = email
      @password = password

      @client = HTTPClient.new
      @client.set_cookie_store("cookie.dat")

      login(email, password)
    end

    def debug!
      @client.debug_dev = STDOUT
    end

    def vehicle
      vehicles.first
    end

    def vehicles
      @vehicles ||= begin
        _, json = get_json("/vehicles")
        json.map { |data| Vehicle.new(self, data) }
      end
    end

    def reload!
      @vehicles = nil
    end

    def logged_in?
      @logged_in
    end
  end
end

