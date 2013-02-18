require 'helper'

class ClimateStateTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def climate_state
    @charge_state ||= begin
      VCR.use_cassette('climate_state', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle.climate_state
      end
    end
  end

  def test_inside_temp_celcius
    assert_equal nil, climate_state.inside_temp_celcius
  end

  def test_outside_temp_celcius
    assert_equal nil, climate_state.outside_temp_celcius
  end

  def test_driver_temp_setting_celcius
    assert_equal 23.1, climate_state.driver_temp_setting_celcius
  end

  def test_passenger_temp_setting_celcius
    assert_equal 23.1, climate_state.passenger_temp_setting_celcius
  end

  def test_fan_speed
    assert_equal nil, climate_state.fan_speed
  end

  def test_auto_conditioning_on
    assert !climate_state.auto_conditioning_on?
  end

  def test_front_defroster_on
    assert !climate_state.front_defroster_on?
  end

  def test_rear_defroster_on
    assert !climate_state.rear_defroster_on?
  end

  def test_fan_on
    assert !climate_state.fan_on?
  end
end

