module TeslaAPI
  # Data defining the driving state of the the vehicle
  class DriveState < Data
    # Time when GPS data was recorded
    attr_reader :gps_timestamp

    ##
    # @method shift_state
    # Unknown

    ##
    # @method speed
    # Vehicle speed (units?)

    ##
    # @method latitude
    # @return [Float] Lattitude of vehicle

    ##
    # @method longitude
    # @return [Float] Longitude of vehicle

    ##
    # @method heading
    # @return [Integer] Compass heading (0 to 360) degrees

    # initialize
    def initialize(data)
      ivar_from_data("shift_state", "shift_state", data)
      ivar_from_data("speed",       "speed",       data)
      ivar_from_data("latitude",    "latitude",    data)
      ivar_from_data("longitude",   "longitude",   data)
      ivar_from_data("heading",     "heading",     data)
      @gps_timestamp = Time.at(data["gps_as_of"])
    end
  end
end

