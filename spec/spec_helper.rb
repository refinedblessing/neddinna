require "simplecov"
require "pry"
require "rack"
SimpleCov.start do
  add_filter "test"
end
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "neddinna"
