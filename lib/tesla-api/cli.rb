require 'thor'

module TeslaAPI
  class CLI < Thor
    include Thor::Actions

    class_option :login
    class_option :password

    def initialize(*args)
      super

      @login    = ENV["TESLA_API_LOGIN"]
      @password = ENV["TESLA_API_PASSWORD"]
    end

    desc "range", "Gets the current rated range of the vehicle"
    def range
      display(vehicle.charge_state.battery_range_miles, "miles")
      display(vehicle.charge_state.battery_range_kilometers, "kilometers")
    end

    desc "inside_temp", "Gets the inside temperature"
    def inside_temp
      display(vehicle.climate_state.inside_temp_celcius, "C")
    end

    desc "outside_temp", "Gets the outside temperature"
    def outside_temp
      display(vehicle.climate_state.outside_temp_celcius.inspect, "C")
    end

    desc "lock", "Locks the car doors"
    def lock
      vehicle.lock_door!

      puts "Locking..."

      sleep 1

      puts vehicle.state.locked? ? "Doors are locked" : "Doors are unlocked"
    end

    desc "unlock", "Unlocks the car doors"
    def unlock
      vehicle.unlock_door!

      puts "Unlocking..."

      sleep 1

      puts vehicle.state.locked? ? "Doors are locked" : "Doors are unlocked"
    end

    desc "cool TEMP", "Starts the A/C on the car and set it to the desired temp"
    def cool(temp)
      vehicle.set_temperature!(temp, temp)
      vehicle.auto_conditioning_start!
    end

    desc "where", "Generates a google maps link showing where your car is"
    def where
      drive_state = vehicle.drive_state

      puts "http://maps.google.com?q=#{drive_state.latitude},#{drive_state.longitude}"
    end

    protected

    def vehicle
      @vehicle ||= begin
        populate_auth(options)

        tesla = TeslaAPI::Connection.new(@login, @password)

        unless tesla.vehicle
          puts "Could not connect to the API and access your vehicle"
          exit 1
        end

        tesla.vehicle
      rescue TeslaAPI::Errors::NotLoggedIn => ex
        puts "Invalid login"
        exit 1
      end
    end

    def display(value, units)
      if value.to_s.empty?
        puts "Could not read data from the vehicle"
      else
        puts "#{value} #{units}"
      end
    end

    def populate_auth(options)
      @login    = options[:login]    if options[:login]
      @password = options[:password] if options[:password]
    end
  end
end

