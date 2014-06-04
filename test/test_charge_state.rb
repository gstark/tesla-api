require 'helper'

class ChargeStateTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def charge_state
    @charge_state ||= begin
      VCR.use_cassette('charge_state', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle.charge_state
      end
    end
  end

  def test_charge_state
    assert_equal "Disconnected", charge_state.charging_state
  end

  def test_supercharging
    assert !charge_state.supercharging?
  end

  def test_charge_port_open
    assert !charge_state.charge_port_open
  end

  def test_charge_rate_miles_per_hour
    assert_equal -1.0, charge_state.charge_rate_miles_per_hour
  end

  def test_hours_to_full_charge
    assert_equal nil, charge_state.hours_to_full_charge
  end

  def test_charge_power
    assert_equal 0, charge_state.charger_power
  end

  def test_charger_actual_amperage
    assert_equal 0, charge_state.charger_actual_amperage
  end

  def test_charger_pilot_amperage
    assert_equal 0, charge_state.charger_pilot_amperage
  end

  def test_charger_voltage
    assert_equal 0, charge_state.charger_voltage
  end

  def test_battery_current_flow
    assert_equal -0.2, charge_state.battery_current_flow
  end

  def test_battery_percentage
    assert_equal 70, charge_state.battery_percentage
  end

  def test_ideal_battery_range_kilometers
    assert_equal 328.48, charge_state.ideal_battery_range_kilometers
  end

  def test_ideal_battery_range_miles
    assert_equal 204.15, charge_state.ideal_battery_range_miles
  end

  def test_estimated_battery_range_kilometers
    assert_equal 231.63, charge_state.estimated_battery_range_kilometers
  end

  def test_estimated_battery_range_miles
    assert_equal 143.96, charge_state.estimated_battery_range_miles
  end

  def test_battery_range_miles
    assert_equal 177.38, charge_state.battery_range_miles
  end

  def test_battery_range_kilometers
    assert_equal 285.40, charge_state.battery_range_kilometers
  end

  def test_charging_to_max
    assert !charge_state.charging_to_max?
  end
end

