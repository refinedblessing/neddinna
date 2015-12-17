require "simplecov"
require "pry"
require "rack"
SimpleCov.start do
  add_filter "spec"
end
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "neddinna"
require_relative "support/mock_controller"
