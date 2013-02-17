module TeslaAPI
  class GUISettings < Data
    def gui_24_hour_time?
      @gui_24_hour_time
    end

    def initialize(data)
      ivar_from_data("gui_distance_units",    "gui_distance_units",    data)
      ivar_from_data("gui_temperature_units", "gui_temperature_units", data)
      ivar_from_data("gui_charge_rate_units", "gui_charge_rate_units", data)
      ivar_from_data("gui_24_hour_time",      "gui_24_hour_time",      data)
      ivar_from_data("gui_range_display",     "gui_range_display",     data)
    end
  end
end

