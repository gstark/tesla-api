module TeslaAPI
  class ClimateState < Data
    def initialize(data)
      ivar_from_data("inside_temp_celcius",            "inside_temp",            data)
      ivar_from_data("outside_temp_celcius",           "outside_temp",           data)
      ivar_from_data("driver_temp_setting_celcius",    "driver_temp_setting",    data)
      ivar_from_data("passenger_temp_setting_celcius", "passenger_temp_setting", data)
      ivar_from_data("fan_speed",                      "fan_speed",              data)

      @auto_conditioning_on   = !!data["is_auto_conditioning_on"]
      @front_defroster_on     = !!data["is_front_defroster_on"]
      @rear_defroster_on      = !!data["is_rear_defroster_on"]
      @fan_on                 = !data["fan_status"].nil?
    end
  end
end

