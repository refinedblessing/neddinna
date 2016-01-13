require "spec_helper"

describe "Deleting a posts", type: :feature do
  before :all do
    setup_app
    setup_table
    Post.create(description: "Desc", title: "Title", author: "jay")
  end

  describe "User wants to get all posts" do
    it "should return all posts created" do
      visit "/posts"

      expect(page).to have_text("Desc")
      expect(page).to have_text("Title")

      click_link "Delete"

      expect(page).to have_text("Post successfully deleted")

      click_link "Back to index page"

      expect(page).not_to have_text("Title")
      expect(page).not_to have_text("Desc")
      expect(Post.first).to eq []
    end
  end
end
