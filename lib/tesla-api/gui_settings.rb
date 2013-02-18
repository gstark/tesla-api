module TeslaAPI
  # Defines the current user settings for the vehicle's graphical display
  class GUISettings < Data
    ##
    # @method gui_distance_units
    # @return [String] Units ("mi/hr") for showing range

    ##
    # @method gui_temperature_units
    # @return [String] Units ("F", "C") for showing temperaturs

    ##
    # @method gui_charge_rate_units
    # @return [String} Units ("kW") for showing charge rage

    ##
    # @method gui_range_display
    # @return [String] Units ("Rated", "Ideal") for showing range

    # true if the UI show 24 hour time (e.g. 17:45)
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

