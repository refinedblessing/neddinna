require "spec_helper"

describe Neddinna::Application do
  include Rack::Test::Methods

  def app
    @app ||= PostApplication
  end

  it "responds to call" do
    expect(app.respond_to?(:call)).to be true
  end

  it "responds with a status of 404 if route is not found" do
    get("/unknownroute")
    expect(last_response.status).to be 404
  end

  it "responds with body that contains 'not found' if route not found" do
    get("/unknownroute")
    expect(last_response.body).to include "not found"
  end

  it "gives a 200 response if route is found" do
    get "/posts"
    expect(last_response).to be_ok
  end
end
