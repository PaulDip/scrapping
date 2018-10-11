require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

e = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes"))


def deputes(f)

full_name =  f.css("h2.titre_normal")
full_name =  full_name.map { |e| e.text  }
full_name = full_name.map { |e| e.split()[1..2]  }
email = f.css("a[href$='assemblee-nationale.fr']")
email =  email.map { |e| e.text  }
carte_de_visite = full_name.zip(email)
carte_de_visite = carte_de_visite.map { |e| e.flatten  }
entries = ["first_name", "last_name", "mail"]
carte_de_visite = carte_de_visite.map { |e| Hash[entries.zip(e)]}
end


def changer_page(f)
urls = []
links = f.css("a.lien_pagination").map { |link| "https://www.voxpublic.org/#{link['href']}" }.uniq

 	until urls.uniq.length > 47
 		begin
 			f = Nokogiri::HTML(open("#{links[5]}"))
 			links = f.css("a.lien_pagination").map { |link| "https://www.voxpublic.org/#{link['href']}" }
 			urls = urls << links
 		rescue
 			next
 		end
 		links = links.drop(0)
 		puts "LOADING..."
	end
	return urls.flatten.uniq
end

for url in changer_page(e)
	g = Nokogiri::HTML(open("#{url}"))
	puts deputes(g)
end 
