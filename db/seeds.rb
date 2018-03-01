# require 'open-uri'
# require 'nokogiri'

# Artist.destroy_all
# puts "create fake artists..."
# artist_names = ["Lou Reed", "The Velvet Underground", "Television", "Iggy Pop", "The Modern Lovers", "John Cale", "PJ Harvey", "Nico", "Marianne Faithfull", "The Stooges", "Richard Hell", "New York Dolls", "Wire", "Suicide", "The Slits", "Nick Cave & The Bad Seeds", "La Femme", "Lescop", "Juniore", "Feu! Chatterton", "Flavien Berger", "Kid Francescoli", "Grand Blanc", "Fishbach", "Agar Agar", "Isaac Delusion", "Vendredi sur Mer", "The Pirouettes", "Sébastien Tellier", "Pépite", "Papooz", "Camp Claude", "Las Aves", "Polo & Pan", "L'Impératrice", "Frànçois & The Atlas Mountains", "Izia", "Skip the Use", "Eiffel", "Mademoiselle K.", "Luke", "Dionysos", "BB Brunes", "Deportivo", "Yodelice", "Brigitte", "Hyphen Hyphen", "Saez", "No One Is Innocent", "Hollysiz", "Mickey 3d", "Miossec", "Naïve New Beaters", "La Grande Sophie", "Cocoon", "AaRON", "Oldelaf", "Patti Smith"]
# artist_names.each do |artist_name|
#   Artist.create(name: artist_name)
# end

# Festival.destroy_all
# puts "create fake festivals..."
# Festival.create(name: "Mainsquare festival")
# Festival.create(name: "Les femmes d'en mêlent")
# Festival.create(name: "Les vieilles charrues")
# Festival.create(name: "Le printemps de bourges")
# Festival.create(name: "Chorus Festival")
# Festival.create(name: "La vilette sonic")

# LineUp.destroy_all
# puts "creating fake line-ups"
# 40.times do
#   lineup = LineUp.new()
#   puts "LineUp.new"
#   lineup.festival = Festival.find(1 + Random.rand(Festival.all.count))
#   puts lineup.festival.name
#   lineup.artist = Artist.find(1 + Random.rand(Artist.all.count))
#   puts lineup.artist.name
#   lineup.save!
#   puts"lineup saved"
# end


#############


require 'rest-client'
require 'json'

paris_festivals = RestClient.get("http://api.songkick.com/api/3.0/events.json?apikey=#{ENV["SONGKICK_API_KEY"]}&location=sk:28909&type=festival", {accept: :json})
paris_festivals = JSON.parse(paris_festivals)
paris_festivals = paris_festivals["resultsPage"]["results"]["event"]
paris_festivals.each do |event|
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
