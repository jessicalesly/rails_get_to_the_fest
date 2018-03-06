class MatchesController < ApplicationController
  def results
    rspotify = SpotifyArtistsService.new(user_hash: current_user.spotify_hash)
    @festival_array = []
    #List of festivals where there is at least one user's artist
    @festivals = Festival.joins(line_ups: :artist).where("artists.name IN (?)", list_spotify_artists(rspotify)).distinct
    @festivals.each do |festival|
      fest_hash = {
        festival_instance: festival,
        artists: list_artists_for_a_fest(rspotify, festival),
      }
      fest_hash[:affinity] = 0
      fest_hash[:artists].each do |artist_hash|
        fest_hash[:affinity] += artist_hash[:score]
      end
      fest_hash[:affinity] = 100 / 50 * fest_hash[:affinity]
      @festival_array <<  fest_hash
    end
    @festival_array.sort_by! { |festival_hash| festival_hash[:affinity] }.reverse!
  end

  private

  def list_spotify_artists(service)
    service.list_artists
  end

  def list_artists_for_a_fest(service, festival)
    service.favorites_artists(festival)
  end
end
