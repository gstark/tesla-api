# TeslaAPI

Allows access to the Tesla REST API for reading car telemetry and controlling basic
vehicle features such as locking doors, opening the roof and controlling the AC system.

Implements the API documented here: https://github.com/timdorr/model-s-api

## Installation

Add this line to your application's Gemfile:

    gem 'tesla-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tesla-api

## Usage

    tesla = TeslaAPI::Connection.new("user@example.com", "password")

    mycar = tesla.vehicle

    mycar.lock_door!

    puts mycar.drive_state.speed # => 65

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
