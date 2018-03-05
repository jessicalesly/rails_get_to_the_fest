class MatchesController < ApplicationController
  def results
    #List of festivals where there is at least one user's artist
    @festivals = Festival.joins(line_ups: :artist).where("artists.name IN (?)", list_spotify_artists).distinct

    @festival_array = []

    @festivals.each do |festival|
      fest_hash = {
        festival_instance: festival,
        artists: list_artists_for_a_fest(festival),
      }
      fest_hash[:affinity] = 0
      fest_hash[:artists].each do |artist_hash|
        fest_hash[:affinity] += artist_hash[:score]
      end
      fest_hash[:affinity] = 100 / 25 * fest_hash[:affinity]
      @festival_array <<  fest_hash
    end

    @festival_array.sort_by! { |festival_hash| festival_hash[:affinity] }.reverse!
  end

  private

  def list_spotify_artists
    SpotifyArtistsService.new(user_hash: current_user.spotify_hash).list_artists
  end

  def list_artists_for_a_fest(festival)
    SpotifyArtistsService.new(user_hash: current_user.spotify_hash).favorites_artists(festival)
  end
end
