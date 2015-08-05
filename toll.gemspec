# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toll/version'

Gem::Specification.new do |spec|
  spec.name          = "toll"
  spec.version       = Toll::VERSION
  spec.authors       = ["Abraham Kuri"]
  spec.email         = ["kurenn@icalialabs.com"]

  spec.summary       = %q{Super simple yet powerful authentication for Rails APIs}
  spec.description   = %q{It is a super simple solution to authenticate users on an API using Rails based authentication_with_token}
  spec.homepage      = "https://github.com/IcaliaLabs/toll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
