require "spec_helper"

describe Neddinna::BaseController do
  let(:request) { Rack::Request.new(Rack::MockRequest.env_for("/posts")) }
  let(:obj) { PostsController.new(request) }
  let(:post) { Post.create(author: "Bb", description: "render test",
                           title: "TI") }
  before :all do
    setup_table
    setup_app
  end

  it "should be superclass for all controllers initialized with request obj" do
    superclass = obj.class.superclass.superclass
    expect(superclass).to eq Neddinna::BaseController
  end

  describe "#klass_folder_name" do
    it "should return name of folder containing controller views files" do
      expect(obj.klass_folder_name).to eq "posts"
    end
  end

  describe "#template" do
    it "should return the erb template of a file if file exists" do
      expect(obj.template(:new).class).to eq Tilt::ERBTemplate
    end

    it "should return false if the file doesn't exist" do
      expect(obj.template(:nonexistent)).to eq false
    end
  end

  describe "#render" do
    it "should display the page view with instance_variables supplied to it" do
      obj.instance_variable_set(:@post, post)
      rendered = obj.render(:show)
      expect(rendered.status).to eq 200
      expect(rendered.body[0]).to include "render test"
    end

    # it "should raise DoubleRenderError if render is called twice" do
    #   obj.instance_variable_set(:@post, post)
    #   obj.render(:show)
    #   expect(obj.render(:show)).to raise_error(DoubleRenderError)
    # end
  end
end
