# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tesla-api/version'

Gem::Specification.new do |gem|
  gem.name          = "tesla-api"
  gem.version       = TeslaAPI::VERSION
  gem.authors       = ["Gavin Stark"]
  gem.email         = ["gavin@gstark.com"]
  gem.description   = %q{Implements the Tesla Model S HTTP API}
  gem.summary       = %q{Implements the Tesla Model S HTTP API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'httpclient', "~> 2.3.2"
end

