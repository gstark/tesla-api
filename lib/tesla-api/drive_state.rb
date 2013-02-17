module TeslaAPI
  class DriveState < Data
    attr_reader :gps_timestamp

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

