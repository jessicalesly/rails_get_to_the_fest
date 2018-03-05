class SpotifyArtistsService
  def initialize(params)
    @spotify_user = RSpotify::User.new(params[:user_hash])
  end

  def top_artists
    top_artists = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'short_term')
    # top_artists << @spotify_user.top_artists(limit: 50, offset: 50, time_range: 'short_term')
    # top_artists.flatten!
    top_artists_array = top_artists.map do |top_artist|
      top_artist.name
    end
    return top_artists_array
  end

  def top_tracks_artists
    top_tracks_recent = @spotify_user.top_tracks(limit: 50, offset:0 ,time_range: 'short_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, offset:50, time_range: 'short_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, offset:100, time_range: 'short_term')
    top_tracks_recent.flatten!

    top_tracks_artists_array = []
    top_tracks_recent.each do |top_track|
      top_track.artists.map do |artist|
        top_tracks_artists_array << artist.name
      end
    end
    return top_tracks_artists_array
  end

  def saved_tracks_artists
    offset_counter = 0
    saved_tracks = @spotify_user.saved_tracks(limit: 50, offset: 0)
    current_batch = [1]

    while current_batch.any?
      offset_counter += 50
      current_batch = @spotify_user.saved_tracks(limit: 50, offset: offset_counter)
      saved_tracks << current_batch
    end
    saved_tracks.flatten!

    saved_tracks_artists_array = []
    saved_tracks.each do |saved_track|
      saved_track.album.artists.each do |artist|
        saved_tracks_artists_array << artist.name
      end
    end

    return saved_tracks_artists_array
  end

  def related_artists
    related_artists_array = []
    top_artists_rspotify = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'short_term')
    top_artists_rspotify.each do |top_artist|
      top_artist.related_artists.each do |related_artist|
        related_artists_array << related_artist.name unless ( top_artists.include?(related_artist.name) || top_tracks_artists.include?(related_artist.name) || saved_tracks_artists.include?(related_artist.name) )
      end
    end
    return related_artists_array
  end

  def list_artists
    # @followed_artists = spotify_user.following(type: 'artist')
    # @saved_albums_10 = spotify_user.saved_albums(limit: 10, offset: 0)
    #Remove duplicates
    return top_artists.uniq! + top_tracks_artists.uniq! + saved_tracks_artists.uniq! + related_artists.uniq!
  end
end
