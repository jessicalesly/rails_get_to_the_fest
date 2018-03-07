class SpotifySynchronisationService
  def initialize(user)
    @user = user
    @spotify_user = RSpotify::User.new(user.spotify_hash)
  end

  def call
    @synchronisation_time = Time.now

    top_artists_array = top_artists
    top_tracks_artists_array = top_tracks_artists
    saved_tracks_artists_array = saved_tracks_artists
    related_artists_array = related_artists
    all_artists = (top_artists_array + top_tracks_artists_array + saved_tracks_artists_array + related_artists_array).uniq

    # Persister
    artists_not_found = persist(top_artists_array, top_tracks_artists_array, saved_tracks_artists_array, related_artists_array, all_artists)

    # Detruire les artistes qui ne sont plus lies au user
    @user.user_artists.where("last_synchronized_at < ?", @synchronisation_time).destroy_all
    @user.update(last_synchronized_at: @synchronisation_time)

    return {
      artists_not_found: artists_not_found,
      synchronisation_time: @synchronisation_time
    }
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

  def persist(top_artists_array, top_tracks_artists_array, saved_tracks_artists_array, related_artists_array, all_artists)
    artists_not_found = []

    all_artists.each do |artist_name|
      artist = Artist.find_by(name: artist_name)

      unless artist
        artists_not_found << artist_name
        next
      end

      user_artist_params = {
        artist: artist,
        is_top_artist: top_artists_array.include?(artist_name),
        is_related: related_artists_array.include?(artist_name),
        nb_top_tracks: top_tracks_artists_array.count(artist_name),
        nb_saved_tracks: saved_tracks_artists_array.count(artist_name),
        last_synchronized_at: @synchronisation_time,
        score: 0
      }
      if user_artist_params[:is_related]
        user_artist_params[:score] = 1
      else
        user_artist_params[:score] += 10 if user_artist_params[:is_top_artist]
        user_artist_params[:score] += 3 * user_artist_params[:nb_top_tracks]
        user_artist_params[:score] += 2 * user_artist_params[:nb_saved_tracks]
      end

      user_artist = @user.user_artists.find_by_artist_id(artist.id)

      if user_artist
        user_artist.update(user_artist_params)
      else
        user_artist = @user.user_artists.create(user_artist_params)
      end
    end

    return artists_not_found
  end

end
