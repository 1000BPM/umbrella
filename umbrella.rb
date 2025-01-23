# Write your soltuion here!
require "http"
require "dotenv/load"

pp "Hi! Where you at?"

user_loc = gets.chomp

#user_loc = "Chicago Booth Harper Center" 

# pp user_loc

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_loc}&key=#{ENV.fetch("GMAPS_KEY")}"

http_returned = HTTP.get(gmaps_url)

json_returned = JSON.parse(http_returned)

# Use parsed JSON to extract nested location information.  Grag latitude and longitude.

lat_loc = json_returned.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
#pp lat_loc

long_loc = json_returned.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
#pp long_loc

#pp gmaps_url

# Acquire and parse current and hourly weather info
pirate_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_KEY")}/#{lat_loc},#{long_loc}"

#pp pirate_url

pirate_http_returned = HTTP.get(pirate_url)

weather_current = JSON.parse(pirate_http_returned).fetch("currently")

temp_current = weather_current.fetch("temperature")
time_current = Time.now.to_i
#time_1hour = Time.now + 1*60*60
#time_1hour = time_1hour.to_i

pp "The current temperature is #{temp_current}"

#Report for 1 hour from now
weather_1hour = JSON.parse(pirate_http_returned).fetch("hourly").fetch("data").at(0)

weather_1hour_temp = weather_1hour["temperature"]

weather_1hour_summary = weather_1hour['summary'].downcase
#weather_1hour_summary = weather_1hour_summary.downcase

pp "In the next hour, the temperature will be #{weather_1hour_temp}F and it will be #{weather_1hour_summary}."
#pp weather_1hour_summary.class
