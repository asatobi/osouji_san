require 'net/http'
require 'open-uri'
require 'json'

class Mattermost
  URI = URI.parse(ENV['REQUEST_URL'])

  def make_request(msg)
    request = Net::HTTP::Post.new(URI)
    request.body = "payload=#{{'text': msg}.to_json}"
    request
  end

  def send(msg)
    request = make_request(msg)
    response = Net::HTTP.start(URI.hostname, URI.port, { use_ssl: true }) do |https|
      https.request(request)
    end
    p '===== Response ====='
    p "code: #{response.code}"
    p "message: #{response.message}"
    p "body: #{response.body}"
    if response.code == '200'
      true
    else
      false
    end
  end

  def make_message(places_and_people)
    message = "|担当者|分担|\n|---|---|\n"
    places_and_people.each do |place, person|
      message << "|#{place}|#{person}|\n"
    end
    message
  end
end
