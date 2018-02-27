class MatchesController < ApplicationController
  def results
    spotify_user = RSpotify::User.new(current_user.spotify_hash)
    # Now you can access user's private data, create playlists and much more
    # Access private data
    @followed_artists = spotify_user.following(type: 'artist')
    @saved_tracks_10 = spotify_user.saved_tracks(limit: 10, offset: 0)
    @saved_albums_10 = spotify_user.saved_albums(limit: 10, offset: 0)
    @top_artists = spotify_user.top_artists #=> (Artist array)
    @top_tracks = spotify_user.top_tracks(time_range: 'short_term')
  end
end
