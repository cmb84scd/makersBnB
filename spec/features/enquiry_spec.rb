require_relative 'web_helpers'

feature 'enables user to make enquiry' do
  scenario 'user inputs text and enquiry is sent to listing owner' do
    user_sign_in

    listing = Listing.create(name: 'House of Horrors', description: 'A very scary house', price: '69.85')
    AvailableDates.create(listing_id: listing.id, date_start: '2020-05-04', date_end: '2020-05-05');
    visit('/')
    click_button('Sign Out')

    User.create(username: 'Unicorn', email: 'collj035@gmail.com', password: '1234')
    User.authenticate(username: 'Unicorn', password: '1234')
    visit("/listings/#{listing.id}/show")

    expect(page).to have_css 'a[href="mailto:lizzieturney@gmail.com"]'
  end
end
