class Tinder

  attr_reader :tinder_token
  attr_reader :connection

  def self.connect
    conn = Faraday.new(:url => 'https://api.gotinder.com') do |faraday|
      faraday.request :json             # form-encode POST params
      faraday.response  :logger                  # log requests to STDOUT
      faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
    end
    # Tinder blocked the Faraday User-Agent.
    # We now must provide the same User-Agent as the iPhone
    conn.headers['User-Agent'] = "Tinder/4.0.9 (iPhone; iOS 8.1.1; Scale/2.00)"
    return conn
  end

  def initialize(fb_id, fb_token, tinder_token)
    @facebook_id = fb_id
    @facebook_token = fb_token
    @tinder_token = tinder_token
    conn = Tinder.connect
    conn.token_auth(tinder_token)
    conn.headers['X-Auth-Token'] = token
    @connection = conn
  end

end
