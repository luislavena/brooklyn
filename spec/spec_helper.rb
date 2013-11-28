# force Rack to run as 'test' environment
ENV["RACK_ENV"] = "test"

require "bundler"
Bundler.setup :default, ENV["RACK_ENV"]

require 'simplecov'
SimpleCov.start do
  add_filter '/vendor/'
end

require "minitest/autorun"
