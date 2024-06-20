# config/initializers/initialize_user.rb

require 'net/http'
require 'json'

Rails.application.config.after_initialize do
  if User.count == 0
    url = 'https://jsonplaceholder.typicode.com/users'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    users = JSON.parse(response)
    puts 'Creating users...'

    users.each do |user_data|
      photo_info = fetch_photo_info(user_data['id'])

      photo_url = photo_info['download_url'] if photo_info

      User.create(
        name: user_data['name'],
        username: user_data['username'],
        email: user_data['email'],
        phone: user_data['phone'],
        website: user_data['website'],
        company: user_data['company'].to_json,
        address: user_data['address'].to_json,
        photo_url: photo_url 
      )
    end
  end
end

def fetch_photo_info(user_id)
  url = URI("https://picsum.photos/id/#{user_id}/info")
  response = Net::HTTP.get(url)
  JSON.parse(response) if response.present?
rescue StandardError => e
  Rails.logger.error("Error fetching photo info for user #{user_id}: #{e.message}")
  nil
end
