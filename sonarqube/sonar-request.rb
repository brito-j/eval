require 'net/http'
require 'uri'

system("sonar-scanner -Dsonar.projectKey=js")
uri = URI.parse("http://localhost:9000/api/issues/search")
response = Net::HTTP.get_response(uri)
puts response.body
