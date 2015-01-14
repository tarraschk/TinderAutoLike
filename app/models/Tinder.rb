class Tinder

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

end
