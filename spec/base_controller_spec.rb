require "spec_helper"

describe Neddinna::BaseController do
  let(:app) { Neddinna::Application.new }
  let(:request) { Rack::MockRequest.new(app) }
  let(:controller) { Neddinna::BaseController::MockController.new(request) }

  it "should have a request object" do
    expect(controller.request.class).to eql Rack::MockRequest
  end
end
