namespace :artist do
  task fetch_picture: :environment do
    Artist.find_each do |artist|
      if artist.picture.nil?
        begin
          artist_results = RSpotify::Artist.search(artist.name)
          unless artist_results == []
            artist_file = artist_results.first
            unless artist_file == []
              pictures = artist_file.images
              puts artist.name
              unless pictures == []
                picture_url = pictures.first["url"]
                artist.picture = picture_url
                artist.save!
                puts "#{artist.name}'s picture updated"
                puts
              end
            end
          end
        rescue => e
          puts e
          puts
        end
      end
    end
  end
end


#### CALL ME WITH rails artist:fetch_picture
