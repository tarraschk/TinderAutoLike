class AccountFb < ActiveRecord::Base

  def generate_account
    browser = Watir::Browser.new
    browser.goto 'https://www.facebook.com/dialog/oauth?client_id=464891386855067&redirect_uri=https://www.facebook.com/connect/login_success.html&scope=basic_info,email,public_profile,user_about_me,user_activities,user_birthday,user_education_history,user_friends,user_interests,user_likes,user_location,user_photos,user_relationship_details&response_type=token'
    browser.text_field(:id => 'email').when_present.set login
    browser.text_field(:id => 'pass').when_present.set password
    browser.button(:name => 'login').when_present.click

    puts 'Fetching Facebook ID...'
    fb_token = /#access_token=(.*)&expires_in/.match(browser.url).captures[0]
    puts 'FB_TOKEN is '+fb_token

    browser.goto'https://www.facebook.com/profile.php'
    fb_id = /fbid=(.*)&set/.match(browser.link(:class =>"profilePicThumb").when_present.href).captures[0]
    puts 'FB_ID is '+fb_id
    fb_name = /.com\/(.*)/.match(browser.url).captures[0]
    puts 'FB_NAME is '+fb_name

    conn = Faraday.new(:url => 'https://api.gotinder.com') do |faraday|
      faraday.request :json             # form-encode POST params
      faraday.response  :logger                  # log requests to STDOUT
      faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
    end
    # Tinder blocked the Faraday User-Agent.
    # We now must provide the same User-Agent as the iPhone
    conn.headers['User-Agent'] = "Tinder/4.0.9 (iPhone; iOS 8.1.1; Scale/2.00)"
    puts 'Fetching your Tinder token...'
    # Authentication, the point is to get your Tinder token
    rsp = conn.post '/auth', {:facebook_token => fb_token, :facebook_id => fb_id}
    jrsp = JSON.parse(rsp.body)
    tinder_token = jrsp["token"]
    puts 'TINDER_TOKEN is '+tinder_token

    Account.create(:name => fb_name, :fb_token => fb_token, :fb_id => fb_id, :tinder_token => tinder_token)

    browser.close
  end

end
