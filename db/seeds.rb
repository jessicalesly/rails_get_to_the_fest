require 'rest-client'
require 'json'

# # # cleaning seeds

p "Cleaning seed..."

 LineUp.destroy_all
 Festival.destroy_all
 Artist.destroy_all

p "Finished cleaning seed"

# # finding all location with SK metro id in France

p "Beginning to map metroarea ids from Songkick..."

city_page = 1 #iterate over this until totalEntries / 50
total_entries = 1000
sg_metroarea_ids = []
until city_page > total_entries
  cities = RestClient.get("http://api.songkick.com/api/3.0/search/locations.json?query=france&apikey=#{ENV["SONGKICK_API_KEY"]}&page=#{city_page}", {accept: :json})
  cities = JSON.parse(cities)
  total_entries = (cities["resultsPage"]["totalEntries"]/50).ceil
  cities = cities["resultsPage"]["results"]["location"]
  cities.each do |city|
    unless sg_metroarea_ids.include?(city["metroArea"]["id"])
      sg_metroarea_ids << city["metroArea"]["id"]
    end
  end
  city_page += 1
end

p "Finished mapping metroarea ids from Songkick"

# # iterating over festivals for a specific location

sg_metroarea_ids.each do |sg_metroarea_id|
  p "Seeding line-ups from metroarea #{sg_metroarea_id}..."
  all_festivals = RestClient.get("http://api.songkick.com/api/3.0/events.json?apikey=#{ENV["SONGKICK_API_KEY"]}&location=sk:#{sg_metroarea_id}&type=festival", {accept: :json})
  all_festivals = JSON.parse(all_festivals)
  all_festivals = all_festivals["resultsPage"]["results"]["event"]
  if all_festivals
    all_festivals.each do |event|
      unless event["performance"] == []
        fest = Festival.new
        fest.name = event["displayName"]
        fest.start_date = event["start"]["date"]
        fest.end_date = event["end"]["date"]
        fest.city = event["venue"]["metroArea"]["displayName"]
        fest.country = event["venue"]["metroArea"]["country"]["displayName"]
        fest.tickets_link = event["uri"]
        fest.save!
        event["performance"].each do |artists|
          lineup = LineUp.new
          lineup.festival = fest
          if Artist.find_by(name: artists["artist"]["displayName"].downcase)
            lineup.artist = Artist.find_by(name: artists["artist"]["displayName"].downcase)
            else
            Artist.create(name: artists["artist"]["displayName"].downcase)
            lineup.artist = Artist.find_by(name: artists["artist"]["displayName"].downcase)
          end
          lineup.save!
        end
      end
    end
  end
end

### ASSOCIATING A PLAYLIST TO EACH EVENT

# Creating the RSpotify user instance that creates playlists
p "Creating a RSpotify User instance with gttf.lewagon..."
admin = RSpotify::User.new(User.find_by(email: "gttf.lewagon@gmail.com").spotify_hash)

# Iterating over festivals in DB

p "Mapping existing playlists on the account..."
ADMIN_PLAYLISTS = []
counter = 0
PLAYLIST_NAMES = []
while admin.playlists(limit: 50, offset: counter).count > 0
  ADMIN_PLAYLISTS = ADMIN_PLAYLISTS + admin.playlists(limit: 50, offset: counter)
  counter += 50
end
ADMIN_PLAYLISTS.each { |playlist| PLAYLIST_NAMES << playlist.name }

p "Associating playlists with matching festival names..."
Festival.all.each do |festival|
  if PLAYLIST_NAMES.include?(festival.name)
    festival_playlists = ADMIN_PLAYLISTS.select { |playlist| playlist.name == festival.name }
    spotify_playlist = festival_playlists.first.external_urls["spotify"]
    festival.playlist = spotify_playlist
    festival.save
  else
    puts festival.name
    puts "WARNING: This festival has no playlist or lineup, you might want to create one on @Spotify#gttf.lewagon@gmail.com"
  end
end

p "😂😂😂 Done seeding playlists ! 😂😂😂"

## 🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫🚫
## PLAYLIST GENERATOR - DO NOT USE UNLESS YOU NEED TO GENERATE NEW PLAYLISTS
## PLAYLISTS ARE AVAILABLE ON Spotify account gttf.lewagon@gmail.com

# Festival.all.each do |festival|
#   unless PLAYLIST_NAMES.include?(festival.name)
#     p festival.name
#     unless festival.artists.nil?
#       artist_tracks = []
#       festival.artists.pluck(:name).each do |artist|
#         unless RSpotify::Track.search(artist, limit: 1).first == nil
#           artist_track = RSpotify::Track.search(artist, limit: 1)
#           artist_tracks << artist_track
#         end
#       end
#       unless artist_tracks == []
#         p festival.name
#         festival_playlist = admin.create_playlist!(festival.name, public: true)
#         festival_playlist.add_tracks!(artist_tracks.flatten)
#         festival.playlist = festival_playlist.external_urls["spotify"]
#         festival.save!
#       end
#     end
#   end
# end
# p "Finished creating your playlists"
