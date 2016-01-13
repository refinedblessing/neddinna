require "spec_helper"

describe "Getting all posts", type: :feature do
  before :all do
    setup_app
    setup_table
    Post.create(description: "Desc", title: "Title", author: "jay")
  end

  describe "User wants to get all posts" do
    it "should return all posts created" do
      visit "/posts/edit/1"

      expect(page).to have_text("Desc")

      fill_in "post[author]", with: "My updated Author"
      fill_in "post[title]", with: "My updated Title"
      fill_in "post[description]", with: "My updated Description"
      click_button "Update Post"

      expect(page).to have_text("My updated author")
      expect(page).to have_text("My updated Title")
      expect(Post.first.title).to eq "My updated Title"
      expect(Post.first.author).to eq "My updated Author"
    end
  end
end
