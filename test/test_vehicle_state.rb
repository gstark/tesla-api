require 'helper'

class VehicleStateTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def vehicle_state
    @vehicle_state ||= begin
      VCR.use_cassette('vehicle_state', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle.state
      end
    end
  end

  def test_firmware_version
    assert_equal "1.19.42", vehicle_state.firmware_version
  end

  def test_nineteen_inch_wheels
    assert vehicle_state.nineteen_inch_wheels?
  end

  def test_panoramic
    assert vehicle_state.panoramic?
  end

  def test_perf
    assert !vehicle_state.perf?
  end

  def test_spoiler
    assert !vehicle_state.spoiler?
  end

  def test_dark_rims
    assert !vehicle_state.dark_rims?
  end

  def test_locked
    assert vehicle_state.locked?
  end

  def test_rear_trunk_open
    assert !vehicle_state.rear_trunk_open?
  end

  def test_rear_trunk_open
    assert !vehicle_state.rear_trunk_open?
  end

  def test_passenger_front_door_open?
    assert !vehicle_state.passenger_front_door_open?
  end

  def test_passenger_rear_door_open?
    assert !vehicle_state.passenger_rear_door_open?
  end

  def test_driver_front_door_open?
    assert !vehicle_state.driver_front_door_open?
  end

  def test_driver_rear_door_open?
    assert !vehicle_state.driver_rear_door_open?
  end

  def test_sun_roof_percent_open
    assert_equal 0, vehicle_state.sun_roof_percent_open
  end

  def test_sun_roof_state
    assert_equal "unknown", vehicle_state.sun_roof_state
  end

  def test_sun_roof_installed?
    assert vehicle_state.sun_roof_installed?
  end
end

