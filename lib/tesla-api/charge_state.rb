module TeslaAPI

  # Defines the current charge state of the vehicle
  class ChargeState < Data
    ##
    # :method: charging_state
    # Charging state ("Complete", "Charging")

    ##
    # :method charging_to_max?
    # true if currently performing a range charge

    ##
    # :method: battery_range_miles
    # Rated miles for the current charge

    ##
    # :method: estimated_battry_range_miles
    # Range estimated from current driving

    ##
    # :method: ideal_battery_range_miles
    # Ideal range for the current charge

    ##
    # :method: battery_percentage
    # Percentage of battery charge

    ##
    # :method: battery_current_flow
    # Current flowing into the battery

    ##
    # :method: charger_voltage
    # Current voltage being used to charge battery

    ##
    # :method: charger_pilot_amperage
    # Max amperage allowed by the charger

    ##
    # :method: charger_actual_amperage
    # Current amperage being drawn into battery

    ##
    # :method: charger_power
    # Kilowatt of charger (rounded down)

    ##
    # :method: hours_to_full_charge
    # Hours remaining until the vehicle is fully charged

    ##
    # :method: charge_rate_miles_per_hour
    # Miles of range being added per hour

    ##
    # :method: charge_port_open?
    # true if the charge port is open

    ##
    # :method: supercharging?
    # true if charging via a Tesla SuperCharger

    def initialize(data) # :nodoc:
      ivar_from_data("charging_state",               "charging_state",         data)
      ivar_from_data("charging_to_max",              "charge_to_max_range",    data)
      ivar_from_data("battery_range_miles",          "battery_range",          data)
      ivar_from_data("estimated_battry_range_miles", "est_battery_range",      data)
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

      @charging        = charging_state == "Charging"
      @charge_complete = charging_state == "Complete"
    end
  end
end

