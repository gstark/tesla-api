require 'rubygems'
require 'test/unit'
require 'vcr'
require 'tesla-api'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

