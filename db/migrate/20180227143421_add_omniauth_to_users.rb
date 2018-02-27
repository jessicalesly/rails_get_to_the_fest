class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :expires_at, :integer
    add_column :users, :spotify_picture_url, :string
    add_column :users, :spotify_profile_url, :string
    add_column :users, :spotify_hash, :string
  end
end
