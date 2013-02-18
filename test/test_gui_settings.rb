require 'helper'

class GuiSettingsTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def gui_settings
    @gui_settings ||= begin
      VCR.use_cassette('gui_settings', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle.gui_settings
      end
    end
  end

  def test_gui_range_display
    assert_equal "Rated", gui_settings.gui_range_display
  end

  def test_gui_charge_rate_units
    assert_equal "kW", gui_settings.gui_charge_rate_units
  end

  def test_gui_temperature_units
    assert_equal "F", gui_settings.gui_temperature_units
  end

  def test_gui_distance_units
    assert_equal "mi/hr", gui_settings.gui_distance_units
  end

  def test_gui_24_hour_time
    assert !gui_settings.gui_24_hour_time?
  end
end

