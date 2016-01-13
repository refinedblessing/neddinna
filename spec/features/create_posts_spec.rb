require "spec_helper"

describe "Creating a new post", type: :feature do
  before :all do
    setup_table
    setup_app
  end

  describe "User creates a new post" do
    it "should create a new post" do
      visit "/posts/new"

      fill_in "post[author]", with: "My test Author"
      fill_in "post[title]", with: "My test Title"
      fill_in "post[description]", with: "My test Description"
      click_button "Create"

      expect(page).to have_text("My test author")
      expect(page).to have_text("My test Title")
      expect(Post.last.title).to eq "My test Title"
      expect(Post.last.author).to eq "My test Author"
    end
  end
end
