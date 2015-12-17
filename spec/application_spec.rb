require "spec_helper"
require "yaml"

describe Neddinna::Application do
  let(:app) { Neddinna::Application.new }
  let(:request) { Rack::MockRequest.new(app) }

  it "is an object of Application class" do
    expect(app.class).to eql Neddinna::Application
  end

  it "responds to call" do
    expect(app.respond_to?(:call)).to be true
  end

  it "responds with a status of 404 if route is not found" do
    response = request.get("/")
    expect(response.status).to be 404
  end

  it "responds with body that contains 'Page not found' if route not found" do
    response = request.get("/")
    expect(response.body).to eql "Page not found"
  end

  describe "routing to appropriate controller" do
    before :each do
      MockApp = app
      require_relative "support/mock_routes"
    end

    it "matches request to appropriate controller action" do
      response = request.get("/index?id=3")
      expect(response.status).to be 200
      expect(response.body).to eql "Mock index 3"
    end
  end
end
