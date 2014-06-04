module TeslaAPI
  # Defines a Model S vehicle returned from the API
  class Vehicle < Data
    # An array of Tesla defined option codes
    attr_reader :option_codes

    ##
    # @method color
    # @return [String] Should be car color but is always nil

    ##
    # @method display_name
    # @return [String] Only observed as nil

    ##
    # @method id
    # @return Vehicle ID used in other API calls

    ##
    # @method user_id
    # @return [Integer] Logged in user ID

    ##
    # @method vehicle_id
    # @return [Integer] Vehicle ID used in streaming API

    ##
    # @method vin
    # @return [String] Vehicle Identification Number

    ##
    # @method tokens
    # @return [Array] API tokens (first is used for streaming API)

    ##
    # @method online_state
    # @return [String] "online" if currently online with API (streaming?)

    ##
    # @method option_codes
    # @return [Array] option codes defining how the vehicle is configured

    def initialize(tesla, data)
      @tesla = tesla

      ivar_from_data("color",        "color",        data)
      ivar_from_data("display_name", "display_name", data)
      ivar_from_data("id",           "id",           data)
      ivar_from_data("user_id",      "user_id",      data)
      ivar_from_data("vehicle_id",   "vehicle_id",   data)
      ivar_from_data("vin",          "vin",          data)
      ivar_from_data("tokens",       "tokens",       data)
      ivar_from_data("online_state", "state",        data)

      @option_codes = data["option_codes"].split(",")
    end

    # true if the vehicle allows mobile access
    def mobile_access?
      tesla.api_mobile_access?(self)
    end

    # @return [String] the option codes as human readable string
    def option_code_descriptions
      option_codes.map { |code| codes_to_description.fetch(code, code) }.join(", ")
    end

    # @return [Object] the streaming data interface
    def stream
      tesla.stream(self)
    end

    #################################
    #
    # Commands
    #
    #################################

    # Wakes up the streaming API
    def wake_up!
      tesla.wake_up!(self)
    end

    # Opens the charging port
    def open_charge_port!
      tesla.open_charge_port!(self)
    end

    # Turns on the temperature conditioning
    def auto_conditioning_start!
      tesla.auto_conditioning_start!(self)
    end

    # Turns off the temperature conditioning
    def auto_conditioning_stop!
      tesla.auto_conditioning_stop!(self)
    end

    # Sets the temperature for both the driver and passenger
    def set_temperature!(driver_degrees_celsius, passenger_degrees_celsius)
      tesla.set_temperature!(self, driver_degrees_celsius, passenger_degrees_celsius)
    end

    # Opens the panoramic roof
    #
    # state may be "open", "close", "comfort", or "vent"
    def open_roof!(state)
      tesla.open_roof!(self, state)
    end

    # Locks the vehicle doors
    def lock_door!
      tesla.lock_door!(self)
    end

    # Unlocks the vehicle doors
    def unlock_door!
      tesla.unlock_door!(self)
    end

    # Honks the vehicles horn
    def honk_horn!
      tesla.honk_horn!(self)
    end

    # Flashes the vehicle lights
    def flash_lights!
      tesla.flash_lights!(self)
    end

    # Stops the vehicle charging
    def charge_stop!
      tesla.charge_stop!(self)
    end

    # Starts the vehicle charging
    def charge_start!
      tesla.charge_start!(self)
    end

    # Charge the vehicle for maximum range
    def charge_max_range!
      tesla.charge_max_range!(self)
    end

    # Charge the vehicle to standard range
    def charge_standard!
      tesla.charge_standard!(self)
    end

    #################################
    #
    # Queries
    #
    #################################

    # @return [ChargeState] the vehicle's charge state
    def charge_state
      @charge_state ||= tesla.api_charge_state_for_vehicle(self)
    end

    # @return [ClimateState] the vehicle's climate state
    def climate_state
      @climate_state || tesla.api_climate_state_for_vehicle(self)
    end

    # @return [DriveState] the vehicle's drive state
    def drive_state
      @drive_state ||= tesla.api_drive_state_for_vehicle(self)
    end

    # @return [GUISettings] the vehicle's gui settings
    def gui_settings
      @gui_settings ||= tesla.api_gui_settings_for_vehicle(self)
    end

    # @return [VehicleState] the vehicle's state
    def state
      @state ||= tesla.api_get_vehicle_state_for_vehicle(self)
    end

    private

    def tesla
      @tesla
    end

    def codes_to_description
      {
        "MS01" => "base",
        "RENA" => "region_us",
        "RECA" => "region_canada",
        "TM00" => "standard_trim",
        "TM02" => "signature_trim",
        "DRLH" => "left_hand_drive",
        "DRRH" => "right_hand_drive",
        "PF00" => "no_performance_model",
        "PF01" => "performance_model",
        "BT85" => "battery_85",
        "BT60" => "battery_60",
        "BT40" => "battery_40",
        "PBSB" => "paint_black",
        "PBSW" => "paint_solid_white",
        "PMSS" => "paint_silver",
        "PMTG" => "paint_dolphin_gray_metalic",
        "PMAB" => "paint_metalic_brown",
        "PMMB" => "paint_metalic_blue",
        "PSW"  => "paint_pearl_white",
        "PSR"  => "paint_signature_red",
        "RFBC" => "roof_body_color",
        "RFPO" => "roof_panorama",
        "WT19" => "wheel_silver_19",
        "WT21" => "wheel_silver_21",
        "WTSP" => "wheel_gray_21",
        "IBSB" => "seats_base_textile",
        "IZMB" => "seats_black_leather",
        "IZMG" => "seats_gray_leather",
        "IPMB" => "seats_performance_black_leather",
        "IDPB" => "interior_piano_black",
        "IDLW" => "interior_lacewood",
        "IDOM" => "interior_obeche_wood_matte",
        "IDCF" => "interior_carbon_fiber",
        "IPMG" => "interior_performance_leather",
        "TR00" => "no_third_row_seating",
        "TR01" => "third_row_seating",
        "SU00" => "no_air_suspension",
        "SU01" => "air_suspension",
        "SC00" => "no_supercharger",
        "SC01" => "supercharger",
        "AU00" => "no_audio_upgrade",
        "AU01" => "audio_upgrade",
        "CH00" => "no_second_charger",
        "CH01" => "second_charger",
        "HP00" => "no_hpwc_ordered",
        "HP01" => "hpwc_ordered",
        "PA00" => "no_paint_armor",
        "PA01" => "pait_armor",
        "PS00" => "no_parcel_shelf",
        "PS01" => "parcel_shelf",
        "TP00" => "no_tech_package",
        "TP01" => "tech_package",
        "AD02" => "power_adapter_nema_14-50",
        "X001" => "power_lift_gate",
        "X003" => "navigation",
        "X007" => "premium_exterior_lighting",
        "X011" => "homelink",
        "X013" => "satellite_radio",
        "X014" => "standard_radio",
        "X019" => "performance_exterior",
        "X020" => "no_performance_exterior",
        "X024" => "performance_powertrain",
        "X025" => "no_performance_powertrain",
      }
    end
  end
end

