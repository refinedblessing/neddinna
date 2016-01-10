require_relative "../spec_helper"

describe Neddinna::Router do
  include Rack::Test::Methods

  def app
    @app ||= PostApplication
  end

  it "returns a list of all my posts" do
    get "/posts"
    expect(last_response).to be_ok
  end

  it "returns a form for a new posts" do
    get "/posts/new"
    expect(last_response).to be_ok
  end

  # it "returns first item in my postslist" do
  #   get "/posts/1"
  #   expect(last_response).to be_ok
  # end
  #
  # it "returns form to edit posts with id 2" do
  #   get "/posts/2/edit"
  #   expect(last_response).to be_ok
  # end
  #
  # it "can respond to posts request" do
  #   posts "/posts"
  #   expect(last_response).to be_ok
  # end
  #
  # it "can respond to put request" do
  #   put "/posts/1"
  #   expect(last_response).to be_ok
  # end
  #
  # it "can respond to delete request" do
  #   delete "/posts/1"
  #   expect(last_response).to be_ok
  # end
end
