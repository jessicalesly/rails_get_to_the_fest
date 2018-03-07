class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:spotify]
  has_many :user_artists

  def self.find_for_spotify_oauth(auth)
    # rspotify_user = RSpotify::User.new(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user_music_hash = {}
    spotify_user = RSpotify::User.new(auth)
    user_params = {}
    user_params[:email] = auth.info.email
    user_params[:token] = auth.token
    user_params[:refresh_token] = auth.credentials.refresh_token
    user_params[:provider] = auth.provider
    user_params[:uid] = auth.uid
    user_params[:expires_at] = auth.credentials.expires_at
    user_params[:spotify_hash] = spotify_user.to_hash
    user_params[:spotify_picture_url] = auth.info.images.first.url if auth.info.images.first
    user_params[:spotify_profile_url] = auth.info.external_urls.spotify
    user_params = user_params.to_h

    if user
      user.update(user_params) #updating the authentification hash # updating user's hash for rspotify requests
      # user.music_hash = user_music_hash
    else # setting up a new user
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]
      user.save!
    end

    #calls to stoptify
    user.update_spotify_user_artists

    return user #returning user for omniauth controller
  end

  def update_spotify_user_artists
    spotify_service = SpotifySynchronisationService.new(self)
    spotify_service.call
  end
end
