class MatchesController < ApplicationController
  def results
    spotify_user = RSpotify::User.new(current_user.spotify_hash)
    # Now you can access user's private data, create playlists and much more
    # Access private data
    @followed_artists = spotify_user.following(type: 'artist')
    @saved_tracks_10 = spotify_user.saved_tracks(limit: 10, offset: 0)
    @saved_albums_10 = spotify_user.saved_albums(limit: 10, offset: 0)
    @top_artists = spotify_user.top_artists #=> (Artist array)
    @top_tracks_recent = spotify_user.top_tracks(time_range: 'short_term')
    @top_tracks_medium = spotify_user.top_tracks(time_range: 'medium_term')
    @top_tracks_long = spotify_user.top_tracks(time_range: 'long_term')
    @top_tracks = spotify_user.top_tracks

    @festival_array = []

    #Creation of 3 arrays Top_artists, Top_tracks_artists, Related_artists
    @top_artists_array = []
    @top_artists.each do |top_artist|
      @top_artists_array << top_artist.name
    end

    @top_tracks_artists_array = []
    @top_tracks_recent.each do |top_track|
      top_track.artists.map do |artist|
        @top_tracks_artists_array << artist.name unless @top_artists_array.include?(artist.name)
      end
    end

    @related_artists_array = []
    @top_artists.each do |top_artist|
      top_artist.related_artists.each do |related_artist|
        @related_artists_array << related_artist.name unless ( @top_artists_array.include?(related_artist.name) || @top_tracks_artists_array.include?(related_artist.name) )
      end
    end

    @top_tracks_recent.each do |top_track|
      top_track.artists.each do |artist|
        artist.related_artists.each do |related|
          @related_artists_array << related.name unless ( @top_artists_array.include?(related.name) || @top_tracks_artists_array.include?(related.name) )
        end
      end
    end

    #Remove duplicates
    @top_artists_array.uniq!
    @top_tracks_artists_array.uniq!
    @related_artists_array.uniq!
    @all_artists = @top_artists_array + @top_tracks_artists_array + @related_artists_array

    #List of festivals where there is at least one user's artist
    @festivals = Festival.joins(line_ups: :artist).where("artists.name IN (?)", @all_artists).distinct.pluck(:name)

    @festivals.each do |festival_name|
      festival = Festival.where(name: festival_name).first
      start_date = DateTime.parse(festival.start_date)
      end_date = DateTime.parse(festival.end_date)
      festival_hash = {
        festival_name: festival_name,
        date: [Time.new(start_date.year,start_date.month,start_date.day), Time.new(end_date.year,end_date.month,end_date.day)],
        location: [festival.city.capitalize, festival.country.capitalize],
        desc: "Le Main Square Festival est un festival de musique qui se déroule à la citadelle d'Arras. Il se caractérise par une programmation internationale et une rivalité avec le festival des Eurockéennes. Le festival fêtera cette année ses 15 ans",
        top_artists: festival.artists.where("artists.name IN (?)", @top_artists_array).pluck(:name),
        top_tracks_artists: festival.artists.where("artists.name IN (?)", @top_tracks_artists_array).pluck(:name),
        related_artists: festival.artists.where("artists.name IN (?)", @related_artists_array).pluck(:name)
      }
      @festival_array <<  festival_hash
    end

    @festival_array.each do |festival_hash|
      festival_hash[:score] = 100 / 25 * (festival_hash[:top_artists].count * 5 + festival_hash[:top_tracks_artists].count * 3 + festival_hash[:related_artists].count)
    end

    @festival_array.sort_by! { |festival_hash| festival_hash[:score] }.reverse!

  end
end
