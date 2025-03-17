feature 'Booking' do
  scenario 'user clicks Book button' do
    user_sign_in
    listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")
    Picture.create(url: 'https://live.staticflickr.com/4159/33385628794_b912df519b_m.jpg', listing_id: listing.id.to_s)
    AvailableDates.create(listing_id: listing.id, date_start: '2020-05-04', date_end: '2020-05-05');
    visit "/listings/#{listing.id}/show"

    expect(page).to have_button "Book"
    click_button "Book"
    expect(current_path).to eq "/booking/#{listing.id}/book"
    expect(page).to have_content "Please select dates below"
    expect(page).to have_field "book_from"
    expect(page).to have_field "book_to"
    expect(page).to have_button "Submit"
  end
end
