require 'helper'

class DriveStateTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def drive_state
    @drive_state ||= begin
      VCR.use_cassette('drive_state', :record => RECORD_MODE) do
        TeslaAPI::Connection.new(USER, PASSWORD).vehicle.drive_state
      end
    end
  end

  def test_shift_state
    assert_equal nil, drive_state.shift_state
  end

  def test_speed
    assert_equal nil, drive_state.speed
  end

  def test_latitude
    assert_equal 17.82365, drive_state.latitude
  end

  def test_longitude
    assert_equal -72.752896, drive_state.longitude
  end

  def test_heading
    assert_equal 180, drive_state.heading
  end
end

