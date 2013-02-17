module TeslaAPI
  # Data defining the driving state of the the vehicle
  class DriveState < Data
    # Time when GPS data was recorded
    attr_reader :gps_timestamp

    ##
    # :method: shift_state
    # Unknown

    ##
    # :method: speed
    # Vehicle speed (units?)

    ##
    # :method: latitude
    # Lattitude of vehicle

    ##
    # :method: longitude
    # Longitude of vehicle

    ##
    # :method: heading
    # Compass heading (0 to 360) degrees

    def initialize(data) # :nodoc:
      ivar_from_data("shift_state", "shift_state", data)
      ivar_from_data("speed",       "speed",       data)
      ivar_from_data("latitude",    "latitude",    data)
      ivar_from_data("longitude",   "longitude",   data)
      ivar_from_data("heading",     "heading",     data)
      @gps_timestamp = Time.at(data["gps_as_of"])
    end
  end
end

