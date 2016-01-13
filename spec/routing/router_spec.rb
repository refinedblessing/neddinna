require_relative "../spec_helper"

describe Neddinna::Router, type: :routing do
  before :all do
    setup_app
    setup_table
  end

  it "should allow get /posts to be routable" do
    get "/posts"
    expect(last_response).to be_ok
  end

  it "should allow get /posts/new to be routable" do
    get "/posts/new", post: { author: "Bb", description: "The post",
                              title: "title" }
    expect(last_response.status).to eql 200
    expect(last_response.body).to include "New"
  end

  it "should allow for post requests" do
    post "/posts", post: { author: "Bb", description: "The post",
                           title: "title" }
    expect(last_response.status).to eq 200
    expect(Post.all.count).to eq 1
  end

  it "should allow for parameters to passed through the url" do
    get "/posts/1"
    expect(last_response.status).to eq 200
    expect(last_response.body).to include "Bb"
  end

  it "should respond with correct contents in template" do
    get "/posts/edit/1"
    expect(last_response.status).to eq 200
    expect(last_response.body).to include "The post"
  end

  it "should render new contents of body when obj is changed" do
    post "/posts/1", post: { author: "Bb", description: "The post",
                             title: "Updated", id: 1 }
    expect(last_response.status).to eq 200
    expect(Post.first.title).to eq "Updated"
  end

  it "can respond to delete request" do
    get "/posts/delete/1"
    expect(last_response.status).to eq 200
    expect(Post.first).to eq []
  end
end
