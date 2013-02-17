module TeslaAPI
  class Vehicle < Data
    attr_reader :option_codes

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

    def mobile_access?
      tesla.api_mobile_access?(self)
    end

    def option_code_descriptions
      option_codes.map { |code| codes_to_description.fetch(code, code) }.join(", ")
    end

    def stream
      tesla.stream(self)
    end

    #################################
    #
    # Commands
    #
    #################################

    def wake_up!
      tesla.wake_up!(self)
    end

    def open_charge_port!
      tesla.open_charge_port!(self)
    end

    def auto_conditioning_start!
      tesla.auto_conditioning_start!(self)
    end

    def auto_conditioning_stop!
      tesla.auto_conditioning_stop!(self)
    end

    def set_temperature!(driver_degrees_celcius, passenger_degrees_celcius)
      tesla.set_temperature!(self, driver_degrees_celcius, passenger_degrees_celcius)
    end

    # state may be "open", "close", "comfort", or "vent"
    def open_roof!(state)
      tesla.open_roof!(self, state)
    end

    def lock_door!
      tesla.lock_door!(self)
    end

    def unlock_door!
      tesla.unlock_door!(self)
    end

    def honk_horn!
      tesla.honk_horn!(self)
    end

    def flash_lights!
      tesla.flash_lights!(self)
    end

    def charge_stop!
      tesla.charge_stop!(self)
    end

    def charge_start!
      tesla.charge_start!(self)
    end

    def charge_max_range!
      tesla.charge_max_range!(self)
    end

    def charge_standard!
      tesla.charge_standard!(self)
    end

    #################################
    #
    # Queries
    #
    #################################

    def charge_state
      @charge_state ||= tesla.api_charge_state_for_vehicle(self)
    end

    def climate_state
      @climate_state || tesla.api_climate_state_for_vehicle(self)
    end

    def drive_state
      @drive_state ||= tesla.api_drive_state_for_vehicle(self)
    end

    def gui_settings
      @gui_settings ||= tesla.api_gui_settings_for_vehicle(self)
    end

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

