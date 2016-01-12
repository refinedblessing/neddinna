require "spec_helper"

describe "Neddinna::Application" do
  before do
    setup_app
  end

  it "responds to call" do
    expect(app.respond_to?(:call)).to be true
  end

  it "responds with a status of 404 if route is not found" do
    get "/unknownroute"
    expect(last_response.status).to be 404
  end

  it "responds with body that contains 'not found' if route not found" do
    get "/unknownroute"
    expect(last_response.body).to include "not found"
  end

  it "gives a 200 response if route is found" do
    get "/posts"
    expect(last_response.status).to be 200
  end

  it "responds even without a template" do
    no_template_call = app.call(Rack::MockRequest.env_for("/no_template"))
    expect(no_template_call.body[0]).to eq "I have no template"
    expect(no_template_call.status).to eq 200
  end
end
