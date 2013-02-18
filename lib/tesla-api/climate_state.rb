module TeslaAPI
  # Defines the climate state of the vehicle.
  #
  class ClimateState < Data
    ##
    # @method inside_temp_celcius
    # @return [Float] Temperature (celcius) inside the vehicle

    ##
    # @method outside_temp_celcius
    # @return [Float] Temperature (celcius) outside the vehicle

    ##
    # @method driver_temp_setting_celcius
    # @return [Float] Temperature (celcius) the driver has set

    ##
    # @method passenger_temp_setting_celcius
    # @return [Float] Temperature (celcius) the passenger has set

    ##
    # @method fan_speed
    # @return [Integer] 0 to 6 (or nil)

    ##
    # @method auto_conditioning_on?
    # @return [Boolean] if auto air conditioning is on

    ##
    # @method front_defroster_on?
    # @return [Boolean] if the front defroster is on

    ##
    # @method rear_defroster_on?
    # @return [Boolean] if the rear defroster is on

    ##
    # @method fan_on?
    # @return [Boolean] if the fan is on

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

