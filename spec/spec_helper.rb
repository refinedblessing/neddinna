require "simplecov"
require "pry"
require "rspec"
require "rack/test"
require "capybara"
require "capybara/dsl"
require "codeclimate-test-reporter"

ENV["RACK_ENV"] = "test"
CodeClimate::TestReporter.start
SimpleCov.start do
  add_filter "spec"
end

require_relative "ned_app/config.rb"
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "neddinna"

def setup_table
  Post.drop_table
  Post.create_table
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

def setup_app
  Capybara.app = PostApplication
  Capybara.default_driver = :selenium
end

def app
  PostApplication
end
