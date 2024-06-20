# app/controllers/concerns/user_albums_and_info.rb
require 'net/http'
require 'json'

module UserAlbumsAndInfo
  extend ActiveSupport::Concern

  included do
    before_action :set_user_and_albums_with_info
  end

  private

  def set_user_and_albums_with_info
    @user = User.find(params[:id])
    @albums = fetch_user_albums_with_info(@user.id)
  end

  def fetch_user_albums(user_id)
    uri = URI("https://jsonplaceholder.typicode.com/albums?userId=#{user_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error "Failed to fetch albums: #{e.message}"
    []
  end

  def fetch_first_album_info(album_id)
    uri = URI("https://jsonplaceholder.typicode.com/photos?albumId=#{album_id}")
    response = Net::HTTP.get(uri)
    info = JSON.parse(response)
    info.first
  rescue StandardError => e
    Rails.logger.error "Failed to fetch info for album #{album_id}: #{e.message}"
    nil
  end

  def fetch_user_albums_with_info(user_id)
    albums = fetch_user_albums(user_id)
    albums.each do |album|
      album['info'] = fetch_first_album_info(album['id'])
    end
    albums
  end
end
