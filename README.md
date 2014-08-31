# TinderRuby AutoLiker v1.0.1

Tinder Auto Like with Ruby - Applying A/B testing on human relationships.

Copyright © 2014 Maxime Alay-Eddine @tarraschk - ARGAUS SAS Cybersecurity
http://www.argaus.fr

Licensed under the MIT license.

This script has been made to do a little social experiment, trying to apply A/B testing to Tinder.
Please do not abuse the Tinder community with this script. Try to meet girls in real life and preserve the dignity of human relationships.

# Requirements
A working Tinder account, connected to your Facebook account.
Ruby >= 1.9.2


# Usage

## How to use the script

1) Edit the file and insert your Facebook login/password at lines 22 & 23:

    myLogin = 'YOUR_FACEBOOK_EMAIL_ADDRESS'
    myPassword = 'YOUR_FACEBOOK_PASSWORD'

Please note that these data will be kept private and are just used to connect you to Facebook servers and fetch your Facebook token & id required by Tinder.

2) Launch the script.

    bundle install
    bundle exec ruby TinderAutoLike.rb

Please wait while the script connects you to Facebook, fetches your token & id, connects to the Tinder API and likes every user in your area.
Users liked will be put in the file "targets.txt".

3) Enjoy! Do some A/B testing to optimize your profile or study human relationships :).

## A/B Testing with TinderAutoLike

1) Create a profile and set up your account with a typical picture following one of those categories: adventure/selfie/group/fun.

2) Set up your description according to your picture.

3) Launch the script and wait for a week.

4) Count the number of matches you got and divide by the number of likes (see targets.txt) to get your ratio.

5) Delete your Tinder profile, create a new one and iterate.

# Results

Feel free to share your results with this repo.

Below are what we learnt so far with A/B testing.

##Your pictures
* 1st photo should be a fun one or showing adventure
* 2nd should be normal
* 3rd might be fun
* others pictures might be of your choice

##Your bio
Try to be out of the crowd! Say something fun and interesting that gives the envy to talk with you.

##The opener
Do not use something you found on Reddit/any forum. Be yourself. However, be fun and try to be teasing: there are a lot of creepy guys on the internet, and you have to show that you are not one of them.
