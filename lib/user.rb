require 'pg'
require 'bcrypt'

class User
  attr_reader :id, :email, :username

  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end

  @@current_user = nil

  def self.create(email:, username:, password:)
    encrypted_password = BCrypt::Password.create(password)

    result = DatabaseConnection.query("INSERT INTO users (email, username, password)
      VALUES('#{email}', '#{username}', '#{encrypted_password}') RETURNING id, email, username;")

    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end

  def self.find(id:)
    return nil unless id

    result = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id};")

    User.new(id: result[0]['id'], email: result[0]['email'], username: result[0]['username'])
  end

  def self.authenticate(username:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    @@current_user = User.new(
      id: result[0]['id'],
      email: result[0]['email'],
      username: result[0]['username']
    )
  end

  def self.sign_out
    @@current_user = nil
  end

  def self.current_user
    @@current_user
  end

  def view_bookings
    DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = '#{id}';")
  end

  def listings
    result = DatabaseConnection.query("SELECT * FROM listings WHERE user_id = #{id};")
    result.map do |listing|
      Listing.new(id: listing['id'], name: listing['name'],
      description: listing['description'], price: listing['price'])
    end
  end
end
