require "simplecov"
require "pry"
require "rspec"
require "rack/test"
require "codeclimate-test-reporter"

ENV["RACK_ENV"] = "test"
CodeClimate::TestReporter.start
SimpleCov.start do
  add_filter "spec"
end

require_relative "ned_app/config.rb"
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "neddinna"
