def sign_in_with(user)
  visit '/'
  click_link 'Log in'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

def create_adventure
  visit "/"
  click_link "Create"
  fill_in "Title", with: "New Adventure"
  fill_in "Synopsis", with: "It is a new one"
  click_button "Create Adventure"
end
