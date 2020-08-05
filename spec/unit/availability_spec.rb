require 'availability'

describe AvailableDates do
  describe '.create' do
    it 'submits dates to table' do
      user_sign_in
      listing = Listing.create(name: 'Minerva', description: 'A really fun place on the surface of the sun', price: '25.00')
      available = AvailableDates.create(listing_id: "#{listing.id}", date_start: "2020-05-04", date_end: "2020-05-05")

      expect(listing.id).to eq available.listing_id
      expect(available.date_start).to eq "2020-05-04"
      expect(available.date_end).to eq "2020-05-05"
    end
  end
end
