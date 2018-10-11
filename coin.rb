require 'rubygems'
require 'nokogiri'
require 'open-uri'

e = Nokogiri::HTML(open("https://coinmarketcap.com/"))

def crypto(f)

link_name =  f.css("span.hidden-xs")
link_name =  link_name.map { |e| e.text  }
link_price =  f.css("a.price")
link_price =  link_price.map { |e| e.text  }
market = Hash[link_name.zip(link_price)]

end

puts crypto(e)
