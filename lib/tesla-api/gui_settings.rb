module TeslaAPI
  # Defines the current user settings for the vehicle's graphical display
  class GUISettings < Data
    ##
    # :method: gui_distance_units
    # Units ("mi", "hr") for showing range

    ##
    # :method: gui_temperature_units
    # Units ("F", "C") for showing temperaturs

    ##
    # :method: gui_charge_rate_units
    # Units ("mi", "hr") for showing charge rage

    ##
    # :method: gui_range_display
    # Units ("Rated", "Ideal") for showing range

    # true if the UI show 24 hour time (e.g. 17:45)
    def gui_24_hour_time?
      @gui_24_hour_time
    end

    def initialize(data) # :nodoc:
      ivar_from_data("gui_distance_units",    "gui_distance_units",    data)
      ivar_from_data("gui_temperature_units", "gui_temperature_units", data)
      ivar_from_data("gui_charge_rate_units", "gui_charge_rate_units", data)
      ivar_from_data("gui_24_hour_time",      "gui_24_hour_time",      data)
      ivar_from_data("gui_range_display",     "gui_range_display",     data)
    end
  end
end

