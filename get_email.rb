require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage (url)
page = Nokogiri::HTML(open(url))
puts page.css('td')[7].text
end

#get_the_email_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/vaureal.html")

def get_all_the_urls_of_val_doise_townhalls (url)
  page = Nokogiri::HTML(open(url))
  contacts_links = page.css('a').select{|link| link['class'] == "lientxt"}
  contacts_links.each{|link| puts 'http://annuaire-des-mairies.com' + link['href'][1..-1] }
end

get_all_the_urls_of_val_doise_townhalls ("http://annuaire-des-mairies.com/val-d-oise.html")
