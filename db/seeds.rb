# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)






# Artist.destroy_all
puts "create artists..."
artist_names = ["Lou Reed", "The Velvet Underground", "Television", "Iggy Pop", "The Modern Lovers", "John Cale", "PJ Harvey", "Nico", "Marianne Faithfull", "The Stooges", "Richard Hell", "New York Dolls", "Wire", "Suicide", "The Slits", "Nick Cave & The Bad Seeds", "La Femme" "Lescop", "Juniore", "Feu! Chatterton", "Flavien Berger", "Kid Francescoli", "Grand Blanc", "Fishbach", "Agar Agar", "Isaac Delusion", "Vendredi sur Mer", "The Pirouettes", "Sébastien Tellier", "Pépite", "Papooz", "Camp Claude", "Las Aves", "Polo & Pan", "L'Impératrice", "Frànçois & The Atlas Mountains", "Izia", "Skip the Use", "Eiffel", "Mademoiselle K.", "Luke", "Dionysos", "BB Brunes", "Deportivo", "Yodelice", "Brigitte", "Hyphen Hyphen", "Saez", "No One Is Innocent", "Hollysiz", "Mickey 3d", "Miossec", "Naïve New Beaters", "La Grande Sophie", "Cocoon", "AaRON", "Oldelaf", "Patti Smith"]
artist_names.each do |artist_name|
  Artist.create(name: artist_name)
end

# Festival.destroy_all
puts "create festivals..."
Festival.create(name: "Mainsquare festival")
Festival.create(name: "Les femmes d'en mêlent")
Festival.create(name: "Les vieilles charrues")
Festival.create(name: "Le printemps de bourges")
Festival.create(name: "Chorus Festival")
Festival.create(name: "La vilette sonic")

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
