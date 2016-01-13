require "spec_helper"

describe "Getting all posts", type: :feature do
  before :all do
    setup_app
    setup_table
    Post.create(description: "Desc", title: "Title1", author: "jay1")
    Post.create(description: "Desc", title: "Title2", author: "jay2")
    Post.create(description: "Desc", title: "Title3", author: "jay3")
  end

  describe "User wants to get all posts" do
    it "should return all posts created" do
      visit "/posts"

      expect(page).to have_text("All Posts")
      expect(page).to have_text("Title1")
      expect(page).to have_text("Title2")
      expect(page).to have_text("Title3")
    end
  end
end
