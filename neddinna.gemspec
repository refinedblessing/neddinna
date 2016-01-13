# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "neddinna/version"

Gem::Specification.new do |spec|
  spec.name          = "neddinna"
  spec.version       = Neddinna::VERSION
  spec.authors       = ["Ebowe Blessing"]
  spec.email         = ["blessing.ebowe@andela.com"]
  spec.summary       = "An MVC framework"
  spec.homepage      = "https://nedinna.herokuapp.com/"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").
                       reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "simplecov", "~> 0.11.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_runtime_dependency "rack", "~> 1.6.4"
  spec.add_runtime_dependency "tilt", "~> 2.0.1"
  spec.add_runtime_dependency "sqlite3", "~> 1.3.11"
end
