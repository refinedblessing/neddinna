require "spec_helper"

RSpec.describe Neddinna::Queries do
  before :all do
    setup_table
  end

  before :all do
    Post.create(description: "Desc", title: "first", author: "jay")
    Post.create(description: "Des1", title: "second", author: "jay")
    Post.create(description: "Des2", title: "third", author: "jay")
    Post.create(description: "Des3", title: "fourth", author: "jay")
    Post.create(description: "Des4", title: "last", author: "jay")
  end

  it "should be a superclass for post" do
    expect(Post.superclass.superclass).to eq Neddinna::Queries
  end

  it "should have a table_name" do
    expect(Post.table_name).to eq "posts"
  end

  describe "#first" do
    it "should return the first obj in DB table" do
      first_post = Post.first
      expect(first_post.id).to eql 1
      expect(first_post.title).to eql "first"
    end

    it "should return the first set of number of items specified" do
      first_two_posts = Post.first(2)
      first_of_two_posts = first_two_posts[0]
      second_of_two_posts = first_two_posts[1]
      expect(first_two_posts.count).to eql 2
      expect(first_of_two_posts.id).to eql 1
      expect(second_of_two_posts.id).to eql 2
      expect(first_of_two_posts.title).to eql "first"
      expect(second_of_two_posts.title).to eql "second"
    end
  end

  describe "#last" do
    it "should return the last obj in DB table" do
      last_post = Post.last
      expect(last_post.title).to eql "last"
    end

    it "should return the last set of number of items specified" do
      last_two_posts = Post.last(2)
      second_to_last_of_two_posts = last_two_posts[1]
      last_of_two_posts = last_two_posts[0]
      expect(last_two_posts.count).to eql 2
      expect(second_to_last_of_two_posts.title).to eql "fourth"
      expect(last_of_two_posts.title).to eql "last"
    end
  end

  describe "#take" do
    it "should return random single model object from DB" do
      expect(Post.take.class).to eq Post
    end

    it "should return the number of objects specified" do
      expect(Post.take(2).count).to eq 2
    end
  end

  describe "#all" do
    it "should return all objects in DB table for the model" do
      expect(Post.all.count).to eq 5
    end
  end

  describe "#find(*id)" do
    it "should return the obj with particular id supplied" do
      expect(Post.find(1).title).to eq "first"
    end

    it "should return an empty array if obj is not found" do
      expect(Post.find(10)).to eq []
      expect(Post.find(10, 23)).to eq []
    end

    it "should return array of objs with ids present in parameter" do
      objs = Post.find(1, 2)
      expect(objs.count).to eq 2
      objs.each do |obj|
        expect(1 == obj.id || 2 == obj.id).to be true
      end
    end
  end

  describe "#find_by(col_name, value)" do
    it "should find obj in db where value matches in particular column" do
      third_post = Post.find_by(:title, "third")
      expect(third_post.title).to eql "third"
      expect(third_post.author).to eql "jay"
    end

    it "should return empty array for unmatched query" do
      third_post = Post.find_by(:title, "unmatched")
      expect(third_post).to eql []
    end
  end

  describe "#where(col_name: val)" do
    it "should find all objects that match the query" do
      expect(Post.where(author: "jay").count).to eq 5
    end

    it "should return an array always irrespective of num of objs found" do
      expect(Post.where(title: "first").is_a? Array).to be true
    end
  end

  describe "#destroy(id)" do
    it "should delete object with id supplied from the DB table" do
      Post.destroy(1)
      expect(Post.first.title).not_to eq "first"
    end
  end

  describe "#destroy" do
    it "should delete the obj that calls it from the DB" do
      post = Post.last
      post.destroy
      expect(Post.last.title).not_to eq "last"
    end
  end

  describe "#destroy_all" do
    it "should delete all objs in DB table" do
      Post.destroy_all
      expect(Post.all.count).to eq 0
    end
  end
end
