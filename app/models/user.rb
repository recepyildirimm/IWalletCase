class User < ApplicationRecord
  scope :search_by_username, -> (username) { where("username ILIKE ?", "%#{username}%") }


  has_one_attached :photo

  attr_accessor :street, :suite, :city, :zipcode, :lat, :lng


  before_save :update_address_json

  after_initialize :parse_address_json

  
  def full_address
    address_data = JSON.parse(address)
    "#{address_data['street']}, #{address_data['suite']}, #{address_data['city']} #{address_data['zipcode']}"
  end
  
  private
  
  def parse_address_json
    if address.present?
      address_data = JSON.parse(address)
      self.street = address_data['street']
      self.suite = address_data['suite']
      self.city = address_data['city']
      self.zipcode = address_data['zipcode']
      self.lat = address_data.dig('geo', 'lat')
      self.lng = address_data.dig('geo', 'lng')
    end
  end

  def update_address_json
    self.address = {
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
      geo: {
        lat: lat,
        lng: lng
      }
    }.to_json
  end
end
