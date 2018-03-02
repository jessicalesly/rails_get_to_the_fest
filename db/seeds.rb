require 'rest-client'
require 'json'

# cleaning seeds

p "Cleaning seed..."

LineUp.destroy_all
Festival.destroy_all
Artist.destroy_all

p "Finished cleaning seed"

# finding all location with SK metro id in France

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

# iterating over festivals for a specific location

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
        fest.save
        event["performance"].each do |artists|
          lineup = LineUp.new
          lineup.festival = fest
          if Artist.find_by(name: artists["artist"]["displayName"])
            lineup.artist = Artist.find_by(name: artists["artist"]["displayName"])
          else
            Artist.create(name: artists["artist"]["displayName"])
            lineup.artist = Artist.find_by(name: artists["artist"]["displayName"])
          end
          lineup.save
        end
      end
    end
  end
  p "Finished seeding this metroarea"
end
