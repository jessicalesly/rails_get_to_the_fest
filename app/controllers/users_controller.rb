class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :spotify
  def spotify
      spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
      # Now you can access user's private data, create playlists and much more
      # Access private data
      @user_country = spotify_user.country #=> "US"
      @user_email = spotify_user.email   #=> "example@email.com"
      @followed_artists = spotify_user.following(type: 'artist')
      @saved_tracks_10 = spotify_user.saved_tracks(limit: 10, offset: 0)
      @saved_albums_10 = spotify_user.saved_albums(limit: 10, offset: 0)
      @top_artists = spotify_user.top_artists #=> (Artist array)
      @top_tracks = spotify_user.top_tracks(time_range: 'short_term') #=> (Track array)
      raise
    end
end
