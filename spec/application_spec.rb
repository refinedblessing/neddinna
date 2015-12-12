require "spec_helper"

describe Neddinna::Application do
  let(:app) { Neddinna::Application.new }
  let(:request) { Rack::MockRequest.new(app) }

  it "is an object of Application class" do
    expect(app.class).to eql Neddinna::Application
  end

  it "responds to call" do
    expect(app.respond_to?(:call)).to be true
  end

  it "responds with a status of 200" do
    response = request.get("/")
    expect(response.status).to be 200
  end

  it "responds with body that contains 'Hello Africa'" do
    response = request.get("/")
    expect(response.body).to eql "Hello Africa"
  end
end
