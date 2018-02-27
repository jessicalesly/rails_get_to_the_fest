class ChangeSpotifyHashToHash < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :spotify_hash, :json, using: 'spotify_hash::JSON'
  end
end
