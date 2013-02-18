require 'helper'

class VehicleTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def vehicle
    @vehicle ||= begin
      VCR.use_cassette('vehicle', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle
      end
    end
  end

  def test_vin
    assert_equal "5YJSA", vehicle.vin
  end

  def test_online_state
    assert_equal "online", vehicle.online_state
  end

  def test_option_codes
    assert_equal ["MS01","RENA"], vehicle.option_codes
  end

  def test_option_code_descriptions
    assert_equal "base, region_us", vehicle.option_code_descriptions
  end
end

