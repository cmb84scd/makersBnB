require 'pg'

class Listing

  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id:, name:, description:, price:, user_id: "view only")
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listings;")
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'],
        description: listing['description'], price: listing['price'], user_id: listing['user_id'])
    end
  end

  def self.create(name:, description:, price:)
    result = DatabaseConnection.query("INSERT INTO listings (name, description, price, user_id)
      VALUES('#{name}', '#{description}', '#{price}', '#{User.current_user.id}')
      RETURNING id, name, description, price, user_id;")
    Listing.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'],
      price: result[0]['price'], user_id: result[0]['user_id'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM listings WHERE id = '#{id}'")
    Listing.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'],
      price: result[0]['price'], user_id: result[0]['user_id'])
  end

  def self.update(id:, name:, description:, price:)
    result = DatabaseConnection.query("UPDATE listings SET name = '#{name}',
      description = '#{description}', price = '#{price}' WHERE id = '#{id}'
      RETURNING id, name, description, price;")
    Listing.new(id: result[0]['id'], name: result[0]['name'],
      description: result[0]['description'], price: result[0]['price'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM listings WHERE id = #{id};")
  end

  def pictures
    DatabaseConnection.query("SELECT * FROM pictures WHERE listing_id = '#{id}';")
  end

  def available_dates
    DatabaseConnection.query("SELECT * FROM available_dates WHERE listing_id = '#{id}';")
  end

  def booked_dates
    DatabaseConnection.query("SELECT * FROM bookings WHERE listing_id = '#{id}';")
  end
end
