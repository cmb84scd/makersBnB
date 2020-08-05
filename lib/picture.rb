class Picture

  attr_reader :id, :url, :listing_id

  def initialize(id:, url:, listing_id:)
    @id = id
    @url = url
    @listing_id = listing_id
  end

  def self.create(url:, listing_id:)
    result = DatabaseConnection.query("INSERT INTO pictures (url, listing_id)
      VALUES('#{url}', '#{listing_id}')
      RETURNING id, url, listing_id;")
    Picture.new(id: result[0]['id'], url: result[0]['url'], listing_id: result[0]['listing_id'])
  end

  def self.update(url:, listing_id:)
    result = DatabaseConnection.query("UPDATE pictures SET url = '#{url}'
      WHERE listing_id = '#{listing_id}' RETURNING id, url, listing_id")
    Picture.new(id: result[0]['id'], url: result[0]['url'], listing_id: result[0]['listing_id'])
  end

  def self.delete(listing_id:)
    DatabaseConnection.query("DELETE FROM pictures WHERE listing_id = '#{listing_id}'")
  end
end
