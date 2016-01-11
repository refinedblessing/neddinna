require "spec_helper"

RSpec.describe "BaseModel" do
  let(:post) { Post.new(description: "Desc", title: "Title", author: "jay") }

  before :all do
    setup_table
  end

  it "should be a BaseModel object" do
    expect(Post.superclass).to eql Neddinna::BaseModel
  end

  it "should have class variables table_name and query_string" do
    expect(Post.class_variables).to eq [:@@query_string, :@@table_name]
  end

  it "should set attributes for Model objects " do
    expect(post.title).to eql "Title"
    expect(post.description).to eql "Desc"
    expect(post.author).to eql "jay"
  end

  describe "BaseModel oobject" do
    it "should respond to method_columns and return correct table columns" do
      expect(post.respond_to? :model_columns).to be true
      expect(post.model_columns.size).to eql 4
      expect(post.model_columns.include? "title").to be true
      expect(post.model_columns.include? "author").to be true
    end
  end

  describe "create method" do
    it "should create new model object in database" do
      created_post =
        Post.create(description: "Last created", title: "Title", author: "bae")
      last_created_post = Post.last
      expect(created_post.id).to eq last_created_post.id
    end
  end

  describe "update method" do
    it "should update details of object" do
      post.update(title: "updated title")
      expect(post.title).to eq "updated title"
    end
  end

  describe "save method" do
    it "should save valid records to database" do
      new_post = Post.new
      new_post.title = "testing save"
      new_post.author = "moi"
      new_post.description = "my description"
      new_post.save
      expect(Post.last.title).to eq "testing save"
      expect(Post.last.author).to eq "moi"
    end

    it "should not add invalid records to database" do
      bad_post = Post.new
      bad_post.title = "testing invalid"
      bad_post.save
      expect(Post.last.title).not_to eq "testing invalid"
    end
  end

  describe "#drop_table" do
    it "should delete database table table for model obj from the DB" do
      Post.drop_table
      result = Neddinna::DbConnector.execute("PRAGMA table_info(posts)")
      expect(result.empty?).to be true
    end
  end

  describe "#create_table" do
    it "should create a DB table for model if none exists" do
      Post.create_table
      result = Neddinna::DbConnector.execute("PRAGMA table_info(posts)")
      expect(result.empty?).to be false
    end
  end
end
