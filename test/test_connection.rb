require 'helper'

class ConnectionTest < Test::Unit::TestCase
  USER        = "user@example.com"
  PASSWORD    = "password"
  RECORD_MODE = :new_episodes

  def test_vehicles
    VCR.use_cassette('connection', :record => RECORD_MODE) do
      connection = TeslaAPI::Connection.new(USER, PASSWORD)

      assert connection.vehicles.size > 0
    end
  end

  def test_vehicle
    VCR.use_cassette('connection', :record => RECORD_MODE) do
      connection = TeslaAPI::Connection.new(USER, PASSWORD)

      assert connection.vehicle
    end
  end

  def test_logged_in
    VCR.use_cassette('connection', :record => RECORD_MODE) do
      connection = TeslaAPI::Connection.new(USER, PASSWORD)

      assert connection.logged_in?
    end
  end
end

