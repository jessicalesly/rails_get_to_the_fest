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

    @festival_hash = {}

    @followed_artists.each do |followed_artist|
      artist_db = Artist.find_by(name: followed_artist.name)
      if artist_db
        lineups = LineUp.where(artist_id: artist_db.id)
        lineups.each do |lineup|
          festival_name = lineup.festival.name
          if @festival_hash[festival_name]
            if @festival_hash[festival_name][:followed]
              @festival_hash[festival_name][:followed].push(artist_db.name)
            else
              @festival_hash[festival_name][:followed] = [artist_db.name]
            end
          else
            @festival_hash[festival_name] = {followed: [artist_db.name]}
          end
        end
      end

      followed_artist.related_artists.each do |related_artist|
        related_artist_db = Artist.find_by(name: related_artist.name)
        if related_artist_db
          lineups = LineUp.where(artist_id: related_artist_db.id)
          lineups.each do |lineup|
            if @festival_hash[lineup.festival.name]
              if @festival_hash[lineup.festival.name][:related]
                @festival_hash[lineup.festival.name][:related].push(related_artist_db.name)
              else
                @festival_hash[lineup.festival.name][:related] = [related_artist_db.name]
              end
            else
              @festival_hash[lineup.festival.name] = {
                related: [related_artist_db.name]
              }
            end
          end
        end
      end

    end

    @top_tracks.each do |top_track|
      top_track.artists do |top_track_artist|
        #appeler fonction qui ajoute des festivals où passent chaque top_tack_artist ou ses related artists
      end
    end

    @top_artists.each do |top_artist|
      #appeler fonction qui ajoute des festivals où passent chaque top_artist ou ses related artists
    end



  end
end
