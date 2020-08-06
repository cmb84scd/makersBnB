feature 'Booking Confirmation' do
  scenario 'user can see their booking dates' do
    user_sign_in
    listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")
    Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: "#{listing.id}")
    AvailableDates.create(listing_id: listing.id, date_start: '2020-05-04', date_end: '2020-05-05')

    visit("/booking/#{listing.id}/book")

    fill_in :book_from, with: '2020-05-04'
    fill_in :book_to, with: '2020-05-05'
    click_button "Submit"
    expect(current_path).to eq "/#{listing.id}/booking/confirmation"
    expect(page).to have_content "You have booked the following..."
  end
end
