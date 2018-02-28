require 'open-uri'
require 'nokogiri'

url = 'https://www.songkick.com/search?page=1&query=festival+paris&type=upcoming'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.summary a').each do |element|
  url = "https://www.songkick.com#{element["href"]}"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.ticket-wrapper a').each do |tickets| #getting buy_ticket_link
    # festival = Festival.new(ticket_link: "https://www.songkick.com#{tickets["href"]}")
  end
  html_doc.search('.festival li a').each do |lineup|
    # artist = Artist.new(name: lineup.content)
  end
end
