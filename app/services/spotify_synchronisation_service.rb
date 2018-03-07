class SpotifySynchronisationService
  def initialize(user)
    @user = user
    @spotify_user = RSpotify::User.new(user.spotify_hash)
  end

  def call
    synchronisation_time = Time.now

    @top_artists_array = top_artists
    @top_tracks_artists_array = top_tracks_artists
    @saved_tracks_artists_array = saved_tracks_artists
    @related_artists_array = related_artists

    # TODO: reprendre le taff de l'autre service et mettre en base


    # laisser en bas
    user.user_artists.where("last_synchronised_at < ?", synchronisation_time).destroy_all
  end

  private

end
