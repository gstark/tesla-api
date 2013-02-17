module TeslaAPI
  class VehicleState < Data
    def initialize(data)
      ivar_from_data("firmware_version",          "car_version",           data)
      ivar_from_data("sun_roof_installed",        "sun_roof_installed",    data)
      ivar_from_data("sun_roof_state",            "sun_roof_state",        data)
      ivar_from_data("sun_roof_percent_open",     "sun_roof_percent_open", data)
      ivar_from_data("driver_front_door_open",    "df",                    data)
      ivar_from_data("driver_rear_door_open",     "dr",                    data)
      ivar_from_data("passenger_front_door_open", "pf",                    data)
      ivar_from_data("passenger_rear_door_open",  "pr",                    data)
      ivar_from_data("front_trunk_open",          "ft",                    data)
      ivar_from_data("rear_trunk_open",           "rt",                    data)
      ivar_from_data("locked",                    "locked",                data)
      ivar_from_data("dark_rims",                 "dark_rims",             data)
      ivar_from_data("spoiler",                   "has_spoiler",           data)

      @nineteen_inch_wheels      = data["wheel_type"] == "Base19"
      @panoramic                 = data["roof_color"] == "None"
      @perf                      = data["perf_config"] != "Base"
    end
  end
end

