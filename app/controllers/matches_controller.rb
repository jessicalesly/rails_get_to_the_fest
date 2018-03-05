class MatchesController < ApplicationController
  def results
    @lists_hash = list_spotify_artists
    #List of festivals where there is at least one user's artist
    @festivals = Festival.joins(line_ups: :artist).where("artists.name IN (?)", @lists_hash[:total]).distinct.pluck(:name)

    @festival_array = []

    @festivals.each do |festival_name|
      festival = Festival.where(name: festival_name).first
      start_date = DateTime.parse(festival.start_date)
      end_date = DateTime.parse(festival.end_date)
      festival_hash = {
        festival_name: festival_name,
        date: [Time.new(start_date.year,start_date.month,start_date.day), Time.new(end_date.year,end_date.month,end_date.day)],
        location: [festival.city.capitalize, festival.country.capitalize],
        desc: "Le Main Square Festival est un festival de musique qui se déroule à la citadelle d'Arras. Il se caractérise par une programmation internationale et une rivalité avec le festival des Eurockéennes. Le festival fêtera cette année ses 15 ans",
        top_artists: festival.artists.where("artists.name IN (?)", @lists_hash[:top_artists]).pluck(:name),
        top_tracks_artists: festival.artists.where("artists.name IN (?)", @lists_hash[:top_tracks]).pluck(:name),
        saved_tracks_artists: festival.artists.where("artists.name IN (?)", @lists_hash[:saved_tracks]).pluck(:name),
        related_artists: festival.artists.where("artists.name IN (?)", @lists_hash[:related]).pluck(:name)
      }
      @festival_array <<  festival_hash
    end

    @festival_array.each do |festival_hash|
      festival_hash[:score] = 100 / 25 * (festival_hash[:top_artists].count * 5 + festival_hash[:saved_tracks_artists].count * 4 + festival_hash[:top_tracks_artists].count * 3 + festival_hash[:related_artists].count)
    end

    @festival_array.sort_by! { |festival_hash| festival_hash[:score] }.reverse!
  end

  private

  def list_spotify_artists
    SpotifyArtistsService.new(user_hash: current_user.spotify_hash).list_artists
  end
end
