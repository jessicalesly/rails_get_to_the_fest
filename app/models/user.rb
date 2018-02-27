class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:spotify]

  def self.find_for_spotify_oauth(auth)
    # rspotify_user = RSpotify::User.new(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user_music_hash = {}
    if user
      # user.music_hash = user_music_hash
    else
      spotify_user = RSpotify::User.new(auth)
      user = User.new(email: auth.info.email)
      user.token = auth.token
      user.refresh_token = auth.credentials.refresh_token
      user.provider = auth.provider
      user.uid = auth.uid
      user.expires_at = auth.credentials.expires_at
      user.spotify_hash = spotify_user.to_hash
      user.spotify_picture_url = auth.info.images.first.url
      user.spotify_profile_url = auth.info.external_urls.spotify
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
    return user
  end
end
