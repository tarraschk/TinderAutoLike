# encoding: UTF-8

puts "\
┌────────────────────────────────────────────────────────────────────┐
│ Tinder Ruby AutoLiker v1.0.1                                       │
├────────────────────────────────────────────────────────────────────┤
│ Copyright © 2014 Maxime Alay-Eddine @tarraschk                     │
│ Copyright © 2014 ARGAUS SAS Cybersecurity (http://www.argaus.fr)   │
├────────────────────────────────────────────────────────────────────┤
│ Licensed under the MIT license.                                    │
├────────────────────────────────────────────────────────────────────┤
│ This script has been made to do a little social experience, trying |
| to apply A/B testing to Tinder.                                    |
│ Please do not abuse this script. Try to meet girls in real life    |
| and preserve the dignity of human relationships.                   |
└────────────────────────────────────────────────────────────────────┘
"

# -------------
# CONFIGURATION
# -------------
# Please insert your Facebook credentials below. They won't be sent to anybody except Facebook servers.
# We use them to connect you and to fetch your Facebook Tinder token & id, in order to authenticate with the Tinder server.
myLogin = 'YOUR_FACEBOOK_EMAIL_ADDRESS'
myPassword = 'YOUR_FACEBOOK_PASSWORD'

# ------------
# DEPENDENCIES
# ------------
require 'mechanize'
require 'faraday'
require 'faraday_middleware'
require 'json'

'''
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
'''

puts '==== FACEBOOK ===='
puts '* Fetching Facebook data...'
# Fetching your Facebook Tinder token & id
puts '  - Fetching your Facebook Tinder token...'

tinder_oauth_url = 'https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fauthorize%2F&scope=user_birthday,user_photos,user_education_history,email,user_relationship_details,user_friends,user_work_history,user_likes&response_type=token%2Csigned_request&client_id=464891386855067'.freeze

mechanize = Mechanize.new
mechanize.user_agent = 'Mozilla/5.0 (Linux; U; en-gb; KFTHWI Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Silk/3.16 Safari/535.19'.freeze

login_form = mechanize.get(tinder_oauth_url).form do |f|
  f.email = myLogin
  f.pass = myPassword
end

fb_token = login_form.submit.form.submit.body.split('access_token=')[1].split('&')[0]
puts '=> My FB_TOKEN is '+fb_token

puts '  - Fetching your Facebook ID...'
fb_name = mechanize.get('https://www.facebook.com/profile.php').uri.to_s

fbid_form = mechanize.get('http://findmyfbid.com/').form do |f|
  f.url = fb_name
end
fb_id = /<code>(\d*)<\/code>/.match(fbid_form.submit.body).captures[0]
puts '=> My FB_ID is '+fb_id

puts '* DONE.'

puts '==== TINDER ===='
puts '* Connecting to the Tinder API...'
# Now, let's connect to the Tinder API
conn = Faraday.new(:url => 'https://api.gotinder.com') do |faraday|
  faraday.request :json             # form-encode POST params
  faraday.response  :logger                  # log requests to STDOUT
  faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
end
# Tinder blocked the Faraday User-Agent.
# We now must provide the same User-Agent as the iPhone
conn.headers['User-Agent'] = "Tinder/4.0.9 (iPhone; iOS 8.1.1; Scale/2.00)"
puts '  - Fetching your Tinder token...'
# Authentication, the point is to get your Tinder token
rsp = conn.post '/auth', {:facebook_token => fb_token, :facebook_id => fb_id}
jrsp = JSON.parse(rsp.body)
token = jrsp["token"]

# The resulting token will be used for every requests done on the Tinder API
conn.token_auth(token)
conn.headers['X-Auth-Token'] = token

puts '  - Fetching users in your area...'
# Let's fetch Tinder users in your area
targets = Array.new
begin
  fileTargets = File.open("targets.txt", "a")
  rsp = conn.post 'user/recs'
  jrsp = JSON.parse(rsp.body)
  while(!jrsp["results"].nil?)
    puts '======== LIKING... ========='
    jrsp["results"].each do |target|
      targets.push(target["_id"])
      fileTargets.write(target["_id"]+"\n")
      trsp = conn.get 'like/'+target["_id"]
    end
    rsp = conn.post 'user/recs'
    jrsp = JSON.parse(rsp.body)
  end
  puts '========= DONE! =========='
  puts 'Below are the targets you just liked.'
  puts targets
  puts '======== EXIT... ========='
rescue IOError => e
  #some error
ensure
  fileTargets.close unless fileTargets == nil
end
