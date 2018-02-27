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
      # # Create playlist in user's Spotify account
      # playlist = spotify_user.create_playlist!('my-awesome-playlist')

      # # Add tracks to a playlist in user's Spotify account
      # tracks = RSpotify::Track.search('Know')
      # playlist.add_tracks!(tracks)
      # playlist.tracks.first.name #=> "Somebody That I Used To Know"

      # # Access and modify user's music library
      # spotify_user.save_tracks!(tracks)
      # spotify_user.saved_tracks.size #=> 20
      # spotify_user.remove_tracks!(tracks)

      # albums = RSpotify::Album.search('launeddas')
      # spotify_user.save_albums!(albums)
      # spotify_user.saved_albums.size #=> 10
      # spotify_user.remove_albums!(albums)

      # # Use Spotify Follow features
      # spotify_user.follow(playlist)
      # spotify_user.follows?(artists)
      # spotify_user.unfollow(users)

      # Get user's top played artists and tracks
      @top_artists = spotify_user.top_artists #=> (Artist array)
      @top_tracks = spotify_user.top_tracks(time_range: 'short_term') #=> (Track array)

      # Check doc for more
    end
end
