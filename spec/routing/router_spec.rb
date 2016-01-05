require_relative "../spec_helper"

describe Neddinna::Router do
  include Rack::Test::Methods

  def app
    @app ||= TodoApplication
  end

  it "returns a list of all my todos" do
    get "/todo"
    expect(last_response).to be_ok
  end

  it "returns a form for a new todo" do
    get "/todo/new"
    expect(last_response).to be_ok
  end

  it "returns first item in my todolist" do
    get "/todo/1"
    expect(last_response).to be_ok
  end

  it "returns form to edit todo with id 2" do
    get "/todo/2/edit"
    expect(last_response).to be_ok
  end

  it "can respond to post request" do
    post "/todo"
    expect(last_response).to be_ok
  end

  it "can respond to put request" do
    put "/todo/1"
    expect(last_response).to be_ok
  end

  it "can respond to put request" do
    put "/todo/1"
    expect(last_response).to be_ok
  end

  it "can respond to delete request" do
    delete "/todo/1"
    expect(last_response).to be_ok
  end
end
