feature 'Viewing listings' do
  scenario 'a user can view listings' do
    user_sign_in
    Listing.create(name: 'Minerva', description: 'A tiny house in the middle nowhere', price: '10.50')
    Listing.create(name: 'Boat House', description: 'A boat house on the shores of lake Loch Ness', price: '35.00')

    visit('/')

    expect(page).to have_content 'Welcome to MakersBnB'
    expect(page).to have_content "Minerva A tiny house in the middle nowhere 10.50"
    expect(page).to have_content "Boat House A boat house on the shores of lake Loch Ness 35.00"
  end

  scenario 'a user can select button to visit listings/new' do
    visit '/'

    expect(page).to have_link "List Property"
    click_link 'List Property'

    expect(current_path).to eq '/listings/new'
  end
end

feature 'Sign in' do
  scenario 'a user can sign in' do
    visit '/'
    click_button 'Log Out'

    expect(page).to have_link 'Log In'
    click_link 'Log In'

    expect(current_path).to eq '/sessions/new'
  end
end
