require "rails_helper"

feature "Creating adventure" do

  scenario "user can create an adventure" do
    user = FactoryGirl.create(:user)

    sign_in_with(user)
    click_link "Create"
    fill_in "Title", with: "New Adventure"
    fill_in "Synopsis", with: "It is a new one"
    click_button "Create Adventure"
    visit "/"
    expect(page).to have_content "New Adventure"
  end

end
