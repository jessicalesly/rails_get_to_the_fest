require 'open-uri'
require 'nokogiri'
# require_relative '../models/application_record'
# require_relative '../models/festival'
# require_relative '../models/artist'
# require_relative '../models/line_up'

festival = Festival.new

url = 'https://www.songkick.com/search?page=1&query=festival+paris&type=upcoming'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.summary a').each do |element|
  url = "https://www.songkick.com#{element["href"]}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.date-and-name .h0').map do |element|
    festival_name = element.content
  end
  Festival.create(name: festival_name)

  html_doc.search('.festival li a').each do |lineup|
    artist = Artist.create(name: lineup.content)
    lineup = LineUp.create(festival: festival, artist: artist)
    p lineup
  end

  html_doc.search('.ticket-wrapper a').map do |element|
    element["href"]
    element["data-event-id"] # uid?
    # festival = Festival.new(ticket_link: "https://www.songkick.com#{tickets["href"]}")
  end
  p "next festival"
end
