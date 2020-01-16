require 'net/http'
require 'uri'

system("start /b start.sh")
sleep(60)
puts "sending request..."
system("ruby sonar-request.rb")
system("sh stop.sh")
