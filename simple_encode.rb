require 'rubygems'
gem 'json'
require 'json'
require 'snapfish_signed_client'
require 'encoding_jobs'

class SnapfishVideoPlatform

  ACCOUNT_ID = "<YOUR_ACCOUNT_ID>"
  API_KEY = "<YOUR_API_KEY>"
  SECRET = "<YOUR_SECRET>"  

  def self.encode(job)
    client.post("/transcodes.json", JSON.dump(job))
  end

  def self.get_info(job_id)
    client.get("/transcodes/#{job_id}.json")
  end

  def self.client
    @client ||= SnapfishSignedClient.new(:api_key => API_KEY, :secret => SECRET, :account_id => ACCOUNT_ID)
  end

end
