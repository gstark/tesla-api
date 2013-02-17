module TeslaAPI
  module PrivateAPI # :nodoc:
    def login(email, password)
      params = { "user_session[email]"    => email,
                 "user_session[password]" => password }

      response = @client.post(Connection::HOST + "/login", params)

      @logged_in = (response.status_code == HTTP::Status::FOUND)
    end

    def stream(vehicle)
      raise "Doesn't work yet"

      client = HTTPClient.new

      uri = Connection::STREAMING_HOST + "/stream/#{vehicle.vehicle_id}/?values=speed,odometer,soc,elevation,est_heading,est_lat,est_lng,power,shift_state"

      client.set_basic_auth(uri, streaming_login, vehicle.tokens.first)
      client.get_content(uri) do |chunk|
        p chunk
      end
    end

    def set_temperature!(vehicle, driver_degrees_celcius, passenger_degrees_celcius)
      command!(vehicle, "set_temps", :query => { :driver_degrees_celcius    => driver_degrees_celcius,
                                                 :passenger_degrees_celcius => passenger_degrees_celcius })
    end

    def open_roof!(vehicle, state)
      command!(vehicle, "sun_roof_control", :query => { :state => state })
    end

    def auto_conditioning_stop!(vehicle)
      command!(vehicle, "auto_conditioning_stop")
    end

    def auto_conditioning_start!(vehicle)
      command!(vehicle, "auto_conditioning_start")
    end

    def lock_door!(vehicle)
      command!(vehicle, "door_lock")
    end

    def unlock_door!(vehicle)
      command!(vehicle, "door_unlock")
    end

    def honk_horn!(vehicle)
      command!(vehicle, "honk_horn")
    end

    def flash_lights!(vehicle)
      command!(vehicle, "flash_lights")
    end

    def charge_stop!(vehicle)
      command!(vehicle, "charge_stop")
    end

    def charge_start!(vehicle)
      command!(vehicle, "charge_start")
    end

    def charge_max_range!(vehicle)
      command!(vehicle, "charge_max_range")
    end

    def charge_standard!(vehicle)
      command!(vehicle, "charge_standard")
    end

    def wake_up!(vehicle)
      command!(vehicle, "wake_up")
    end

    def open_charge_port!(vehicle)
      command!(vehicle, "charge_port_open")
    end

    def api_mobile_access?(vehicle)
      _, json = get_json(command_url(vehicle, "mobile_enabled"))

      json["result"] == true
    end

    def api_get_vehicle_state_for_vehicle(vehicle)
      _, json = get_json(command_url(vehicle, "vehicle_state"))

      VehicleState.new(json)
    end

    def api_gui_settings_for_vehicle(vehicle)
      _, json = get_json(command_url(vehicle, "gui_settings"))

      GUISettings.new(json)
    end

    def api_drive_state_for_vehicle(vehicle)
      _, json = get_json(command_url(vehicle, "drive_state"))

      DriveState.new(json)
    end

    def api_climate_state_for_vehicle(vehicle)
      _, json = get_json(command_url(vehicle, "climate_state"))

      ClimateState.new(json)
    end

    def api_charge_state_for_vehicle(vehicle)
      _, json = get_json(command_url(vehicle, "charge_state"))

      ChargeState.new(json)
    end

    private

    def streaming_login
      email.gsub("@","%")
    end

    def check_logged_in!
      raise Errors::NotLoggedIn unless logged_in?
    end

    def command_url(vehicle, command_name)
      "/vehicles/#{vehicle.id}/command/#{command_name}"
    end

    def command!(vehicle, command_name, options = {})
      _, json = get_json(command_url(vehicle, command_name), options)

      json["result"] ? json["result"] : raise(Errors::APIFailure.new(json["reason"]))
    end

    def get_json(uri, options = {})
      check_logged_in!

      response = get(uri, options)

      [response, JSON.parse(response.body)]
    rescue JSON::ParserError => e
      raise Errors::InvalidJSON.new(e)
    end

    def get(uri, options = {})
      response = @client.get(Connection::HOST + uri, options)

      raise Errors::InvalidResponse.new(response) unless response.status_code == HTTP::Status::OK

      response
    end
  end
end

