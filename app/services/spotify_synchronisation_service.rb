class SpotifySynchronisationService
  def initialize(user)
    @user = user
    @spotify_user = RSpotify::User.new(user.spotify_hash)
  end

  def call
    synchronisation_time = Time.now

    top_artists_array = top_artists
    top_tracks_artists_array = top_tracks_artists
    saved_tracks_artists_array = saved_tracks_artists
    related_artists_array = related_artists
    all_artists = (top_artists_array + top_tracks_artists_array + saved_tracks_artists_array + related_artists_array).uniq

    # TODO: reprendre le taff de l'autre service et mettre en base
    all_artists.each do |artist|
      # UserArtist.find_by()
      # UserArtist.new()
    end
    # laisser en bas
    user.user_artists.where("last_synchronised_at < ?", synchronisation_time).destroy_all
  end

  private

  def top_artists
    top_artists = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'medium_term')
    # top_artists << @spotify_user.top_artists(limit: 50, offset: 50, time_range: 'short_term')
    # top_artists.flatten!
    @top_artists_array = top_artists.map do |top_artist|
      top_artist.name.downcase
    end
    return @top_artists_array
  end

  def top_tracks_artists
    top_tracks_recent = @spotify_user.top_tracks(limit: 50, offset:0 ,time_range: 'short_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, offset:50, time_range: 'short_term')
    top_tracks_recent << @spotify_user.top_tracks(limit: 50, offset:100, time_range: 'short_term')
    top_tracks_recent.flatten!

    @top_tracks_artists_array = []
    top_tracks_recent.each do |top_track|
      top_track.artists.map do |artist|
        @top_tracks_artists_array << artist.name.downcase
      end
    end
    return @top_tracks_artists_array
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

    @saved_tracks_artists_array = []
    saved_tracks.each do |saved_track|
      saved_track.album.artists.each do |artist|
        @saved_tracks_artists_array << artist.name.downcase
      end
    end
    return @saved_tracks_artists_array
  end

  def related_artists
    @related_artists_array = []
    top_artists_rspotify = @spotify_user.top_artists(limit: 50, offset: 0, time_range: 'medium_term')
    top_artists_rspotify.each do |top_artist|
      top_artist.related_artists.each do |related_artist|
        @related_artists_array << related_artist.name.downcase unless ( @top_artists_array.include?(related_artist.name.downcase) || @top_tracks_artists_array.include?(related_artist.name.downcase) || @saved_tracks_artists_array.include?(related_artist.name.downcase) )
      end
    end
    top_tracks_rspotify = @spotify_user.top_tracks(limit: 50, offset: 0, time_range: 'medium_term')

    top_tracks_rspotify.each do |top_track|
      top_track.artists.each do |artist|
        artist.related_artists.each do |related_artist|
          @related_artists_array << related_artist.name.downcase unless ( @top_artists_array.include?(related_artist.name.downcase) || @top_tracks_artists_array.include?(related_artist.name.downcase) || @saved_tracks_artists_array.include?(related_artist.name.downcase) )
        end
      end
    end
    return @related_artists_array
  end
end
