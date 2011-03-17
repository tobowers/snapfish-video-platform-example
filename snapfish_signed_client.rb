require 'rubygems'
gem 'httpclient'
require 'httpclient'

require 'digest/sha1'
require 'uri'

class SnapfishSignedClient
  HOST = "https://secure.motionbox.com"
  
  # https://secure.motionbox.com/v1/accounts/<account_id>/transcodes.json?api_key=<api_key>&hashed_secret
  
  def initialize(opts = {})
    @account_id = opts[:account_id]
    @api_key = opts[:api_key]
    @secret = opts[:secret]
  end
  
  #GET /transcodes/<job_id>
  def get(path)
    #$stderr.puts("getting: #{complete_uri_with_path(path).to_s}")
    response = http_client.get(complete_uri_with_path(path))
    return response.content
  end
  
  def post(path, body = "", content_type = "application/json")
    #$stderr.puts("posting: #{complete_uri_with_path(path)} --- with --- #{body}")
    response = http_client.post(complete_uri_with_path(path), body, {"Content-Type" => content_type})
    return response.content
  end

private
  
  def http_client
    HTTPClient.new
  end
  
  def complete_uri_with_path(path)
    uri = default_uri
    uri.path += path
    signed_uri(uri)
  end
    
  # append your api key and hashed secret as query params to your requests
  # so a POST request to /transcodes.json would look like
  # POST https://secure.motionbox.com/v1/accounts/<accountId>/transcodes.json?api_key=<api_key>&hashed_secret=<hashed_secret
  def signed_uri(url_or_uri)
    uri = URI.parse(url_or_uri.to_s)
    additional_query_string = "api_key=#{@api_key}&hashed_secret=#{hashed_secret}"
    join_character = (!uri.query || uri.query == '') ? "" : "&"
    uri.query = [uri.query, additional_query_string].join(join_character)
    return uri
  end
  
  def default_uri
    URI.parse("#{HOST}#{default_path_prefix}")
  end
  
  # All requests should be prepended with /v1/accounts/<yourAccountId>
  def default_path_prefix
    @prefix ||= "/v1/accounts/#{@account_id}"
  end
  
  # Your hashed secret is the SHA1 digest of api_key + secret
  def hashed_secret
    Digest::SHA1.hexdigest(@api_key + @secret)
  end
  
end