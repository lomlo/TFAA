require 'rails_helper'

feature "Creating Adventure" do
  scenario "user can see a create link" do
    user = create(:user)
    log_in_with(user)

    expect(page).to have_link "Create"
  end

  scenario "user can create an adventure" do
    user = create(:user)
    log_in_with(user)

    click_link "Create"

    expect(page).to have_content "Create a new Adventure"
  end

  scenario "user can access an adventure design page" do
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    click_button "submit"

    expect(page).to have_content "Design your Adventure"
    expect(page).to have_link "Start"
  end

  scenario "user can create a chapter" do
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    click_button "submit"

    click_link "Start"
    expect(page).to have_content "Description"
  end

  scenario "user can add to choices to a chapter" do
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    click_button "submit"

    click_link "Start"

    fill_in "Description", with: "Barbara Ann"
    click_button "submit"

    expect(page).to have_content "Option 1"
    expect(page).to have_content "Option 2"
  end
end