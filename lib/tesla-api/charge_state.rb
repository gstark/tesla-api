module TeslaAPI

  # Defines the current charge state of the vehicle
  class ChargeState < Data
    MILE_IN_KM = 1.609344

    attr_reader :battery_range_kilometers, :estimated_battery_range_kilometers, :ideal_battery_range_kilometers

    ##
    # @method charging_state
    # @return Charging state ("Complete", "Charging")

    ##
    # @method charging_to_max?
    # @return [Boolean] true if currently performing a range charge

    ##
    # @method battery_range_kilometers
    # @return [Float] Rated kilometers for the current charge

    ##
    # @method battery_range_miles
    # @return [Float] Rated miles for the current charge

    ##
    # @method estimated_battery_range_kilometers
    # @return [Float] Range estimated from current driving

    ##
    # @method estimated_battery_range_miles
    # @return [Float] Range estimated from current driving

    ##
    # @method ideal_battery_range_miles
    # @return [Float] Ideal range for the current charge

    ##
    # @method battery_percentage
    # @return [Integer] Percentage of battery charge

    ##
    # @method battery_current_flow
    # @return [Float] Current flowing into the battery

    ##
    # @method charger_voltage
    # @return [Float] Current voltage being used to charge battery

    ##
    # @method charger_pilot_amperage
    # @return [Integer] Max amperage allowed by the charger

    ##
    # @method charger_actual_amperage
    # @return [Integer] Current amperage being drawn into battery

    ##
    # @method charger_power
    # @return [Integer] Kilowatt of charger (rounded down)

    ##
    # @method hours_to_full_charge
    # @return [Float] Hours remaining until the vehicle is fully charged

    ##
    # @method charge_rate_miles_per_hour
    # @return [Float] Miles of range being added per hour

    ##
    # @method charge_rate_kilometers_per_hour
    # @return [Float] Kilometers of range being added per hour

    ##
    # @method charge_port_open?
    # @return [Boolean] charge port open state

    ##
    # @method supercharging?
    # @return [Boolean] charging via a Tesla SuperCharger

    def initialize(data)
      ivar_from_data("charging_state",               "charging_state",         data)
      ivar_from_data("charging_to_max",              "charge_to_max_range",    data)
      ivar_from_data("battery_range_miles",          "battery_range",          data)
      ivar_from_data("estimated_battery_range_miles", "est_battery_range",      data)
      ivar_from_data("ideal_battery_range_miles",    "ideal_battery_range",    data)
      ivar_from_data("battery_percentage",           "battery_level",          data)
      ivar_from_data("battery_current_flow",         "battery_current",        data)
      ivar_from_data("charger_voltage",              "charger_voltage",        data)
      ivar_from_data("charger_pilot_amperage",       "charger_pilot_current",  data)
      ivar_from_data("charger_actual_amperage",      "charger_actual_current", data)
      ivar_from_data("charger_power",                "charger_power",          data)
      ivar_from_data("hours_to_full_charge",         "time_to_full_charge",    data)
      ivar_from_data("charge_rate_miles_per_hour",   "charge_rate",            data)
      ivar_from_data("charge_port_open",             "charge_port_door_open",  data)
      ivar_from_data("supercharging",                "fast_charger_present",   data)

      @battery_range_kilometers = (battery_range_miles * MILE_IN_KM).round(2)
      @estimated_battery_range_kilometers = (estimated_battery_range_miles * MILE_IN_KM).round(2)
      @ideal_battery_range_kilometers = (ideal_battery_range_miles * MILE_IN_KM).round(2)

      @charging        = charging_state == "Charging"
      @charge_complete = charging_state == "Complete"
    end
  end
end

