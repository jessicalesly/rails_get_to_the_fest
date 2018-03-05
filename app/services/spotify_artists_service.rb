class SpotifyArtistsService
  def initialize(params)
    @spotify_user = RSpotify::User.new(params[:user_hash])
  end

  def list_artists
    top_tracks_recent = @spotify_user.top_tracks(limit: 50, time_range: 'short_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, time_range: 'medium_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, time_range: 'long_term')
    top_tracks_recent.flatten!


    # @top_artists = spotify_user.top_artists #=> (Artist array)
    top_artists = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'short_term')
    top_artists << @spotify_user.top_artists(limit: 50, offset: 50, time_range: 'short_term')
    top_artists << @spotify_user.top_artists(limit: 50, offset: 100, time_range: 'short_term')
    top_artists.flatten!

    saved_tracks = spotify_user.saved_tracks(limit: 50, offset: 0)
    saved_tracks << spotify_user.saved_tracks(limit: 50, offset: 50)
    saved_tracks << spotify_user.saved_tracks(limit: 50, offset: 100)
    saved_tracks.flatten!


    festival_array = []

    #Creation of 3 arrays Top_artists, Top_tracks_artists, Related_artists
    top_artists_array = []
    top_artists.each do |top_artist|
      top_artists_array << top_artist.name
    end

    top_tracks_artists_array = []
    top_tracks_recent.each do |top_track|
      top_track.artists.map do |artist|
        top_tracks_artists_array << artist.name unless top_artists_array.include?(artist.name)
      end
    end

    saved_tracks_artists_array = []
    saved_tracks.each do |saved_track|
      saved_track.album.artists.each do |artist|
        saved_tracks_artists_array << artist.name unless (@top_artists_array.include?(artist.name) || @top_tracks_artists_array.include?(artist.name) )
      end
    end

    @related_artists_array = []
    @top_artists.each do |top_artist|
      top_artist.related_artists.each do |related_artist|
        @related_artists_array << related_artist.name unless ( @top_artists_array.include?(related_artist.name) || @top_tracks_artists_array.include?(related_artist.name) || @saved_tracks_artists_array.include?(related_artist.name) )
      end
    end

    @top_tracks_recent.each do |top_track|
      top_track.artists.each do |artist|
        artist.related_artists.each do |related|
          @related_artists_array << related.name unless ( @top_artists_array.include?(related.name) || @top_tracks_artists_array.include?(related.name) || @saved_tracks_artists_array.include?(related.name))
        end
      end
    end

    #Remove duplicates
    @top_artists_array.uniq!
    @top_tracks_artists_array.uniq!
    @saved_tracks_artists_array.uniq!
    @related_artists_array.uniq!
    @all_artists = @top_artists_array + @top_tracks_artists_array + @saved_tracks_artists_array +@related_artists_array

  end

end
