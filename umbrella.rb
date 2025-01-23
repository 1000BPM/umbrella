# Write your soltuion here!
require "http"
require "dotenv/load"

pp "Hi! Where you at?"

# user_loc = gets.chomp

user_loc = "Chicago Booth Harper Center" 

# pp user_loc

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

http_returned = HTTP.get(gmaps_url)

json_returned = JSON.parse(http_returned)

# Use parsed JSON to extract nested location information.  Grag latitude and longitude.

lat_loc = json_returned.fetch("results").at(0).fetch("navigation_points").at(0).fetch("location").fetch("latitude")
#pp lat_loc

long_loc = json_returned.fetch("results").at(0).fetch("navigation_points").at(0).fetch("location").fetch("longitude")
#pp long_loc

# pp gmaps_url
