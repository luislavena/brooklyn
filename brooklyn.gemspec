# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brooklyn/version'

Gem::Specification.new do |spec|
  spec.name          = "brooklyn"
  spec.version       = Brooklyn::VERSION
  spec.authors       = ["Luis Lavena"]
  spec.email         = ["luislavena@gmail.com"]
  spec.description   = %q{Brooklyn - A small Sinatra-like wrapper to Rack.}
  spec.summary       = %q{Brooklyn, New York.}
  spec.license       = "MIT"

  # FIXME: do not use backticks
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.required_ruby_version = "~> 2.0.0"

  spec.add_dependency "rack", "< 2.0", ">= 1.5.2"

  spec.add_development_dependency "bundler", "~> 1.3", ">= 1.3.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "simplecov"
end
