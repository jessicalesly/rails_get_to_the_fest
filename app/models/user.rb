class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:spotify]

  def self.find_for_spotify_oauth(auth)
    # rspotify_user = RSpotify::User.new(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    if user
      # rien
    else
      spotify_user = RSpotify::User.new(auth)
      # user = User.new(email: auth.info.email)
      # user.email = auth.email
      # user.token = auth.token
      # user.rspotify_user = RSpotify::User.new(auth)
    end
  end
end
