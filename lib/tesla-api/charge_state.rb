module TeslaAPI
  class ChargeState < Data
    def initialize(data)
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

