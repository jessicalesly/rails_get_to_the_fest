require 'open-uri'
require 'nokogiri'

Artist.destroy_all
puts "create fake artists..."
artist_names = ["Lou Reed", "The Velvet Underground", "Television", "Iggy Pop", "The Modern Lovers", "John Cale", "PJ Harvey", "Nico", "Marianne Faithfull", "The Stooges", "Richard Hell", "New York Dolls", "Wire", "Suicide", "The Slits", "Nick Cave & The Bad Seeds", "La Femme", "Lescop", "Juniore", "Feu! Chatterton", "Flavien Berger", "Kid Francescoli", "Grand Blanc", "Fishbach", "Agar Agar", "Isaac Delusion", "Vendredi sur Mer", "The Pirouettes", "Sébastien Tellier", "Pépite", "Papooz", "Camp Claude", "Las Aves", "Polo & Pan", "L'Impératrice", "Frànçois & The Atlas Mountains", "Izia", "Skip the Use", "Eiffel", "Mademoiselle K.", "Luke", "Dionysos", "BB Brunes", "Deportivo", "Yodelice", "Brigitte", "Hyphen Hyphen", "Saez", "No One Is Innocent", "Hollysiz", "Mickey 3d", "Miossec", "Naïve New Beaters", "La Grande Sophie", "Cocoon", "AaRON", "Oldelaf", "Patti Smith"]
artist_names.each do |artist_name|
  Artist.create(name: artist_name)
end

Festival.destroy_all
puts "create fake festivals..."
Festival.create(name: "Mainsquare festival")
Festival.create(name: "Les femmes d'en mêlent")
Festival.create(name: "Les vieilles charrues")
Festival.create(name: "Le printemps de bourges")
Festival.create(name: "Chorus Festival")
Festival.create(name: "La vilette sonic")

LineUp.destroy_all
puts "creating fake line-ups"
40.times do
  lineup = LineUp.new()
  puts "LineUp.new"
  lineup.festival = Festival.find(1 + Random.rand(Festival.all.count))
  puts lineup.festival.name
  lineup.artist = Artist.find(1 + Random.rand(Artist.all.count))
  puts lineup.artist.name
  lineup.save!
  puts"lineup saved"
end


# sg_page = 0

# (1..4).each do |page|
#   sg_page += 1
#   url = "https://www.songkick.com/search?page=#{sg_page}&query=festival" + "+" + "paris&type=upcoming"
#   html_file = open(url).read
#   html_doc = Nokogiri::HTML(html_file)

#   html_doc.search('.summary a').each do |element|
#     url = "https://www.songkick.com#{element["href"]}"
#     html_file = open(url).read
#     html_doc = Nokogiri::HTML(html_file)

#     html_doc.search('.date-and-name .h0').map do |element|
#       html_doc.at('meta[property="og:locality"]')['content']
#       html_doc.at('meta[property="og:locality"]')['content']
#       festival_json = html_doc.at('script[type="application/ld+json"]')
#       p festival_json.children

#       unless festival_json.nil?
#         festival_name = element.content
#         festival = Festival.create(name: festival_name)
#         html_doc.search('.festival li a').each do |lineup|
#           artist = Artist.create(name: lineup.content)
#           lineup = LineUp.create(festival: festival, artist: artist)
#         end
#       end
#     end

#     html_doc.search('.ticket-wrapper a').map do |element|
#       element["href"]
#       element["data-event-id"] # uid?
#       # festival = Festival.new(ticket_link: "https://www.songkick.com#{tickets["href"]}")
#     end
#     p "next festival"
#   end
# end

