def sign_up
  visit('/signup')
  expect(page).to have_content "Sign Up"
  fill_in('username', with: 'user1')
  fill_in('email', with: 'email@email.com')
  fill_in('password', with: 'password123')
  click_button('Register')
end

def user_sign_in
  User.create(username: 'username', email: 'email@email.com', password: 'test_password')
  User.authenticate(username: 'username', password: 'test_password')
end
