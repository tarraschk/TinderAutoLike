TinderRuby AutoLiker v1.0
=========================

Tinder Auto Like with Ruby - Applying A/B testing on human relationships.

Copyright © 2014 Maxime Alay-Eddine @tarraschk - ARGAUS SAS Cybersecurity
http://www.argaus.fr

Licensed under the MIT license.

This script has been made to do a little social experiment, trying to apply A/B testing to Tinder.
Please do not abuse this script. Try to meet girls in real life and preserve the dignity of human relationships.

How to use it
=============

1) Edit the file and insert your Facebook login/password at lines 22 & 23.

    myLogin = 'YOUR_FACEBOOK_EMAIL_ADDRESS'
    myPassword = 'YOUR_FACEBOOK_PASSWORD'

Please note that these data will be kept private and are just used to connect you to Facebook servers and fetch your Facebook token & id required by Tinder.

2) Launch the script.

    bundle install
    bundle exec ruby TinderAutoLike.rb

Please wait while the script connects you to Facebook, fetches your token & id, connects to the Tinder API and likes every user in your area.
Users liked will be put in the file "targets.txt".

3) Enjoy! Do some A/B testing to optimize your profile or study human relationships :).
