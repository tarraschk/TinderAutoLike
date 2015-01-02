# TinderRuby AutoLiker v1.1.0

Tinder Auto Like with Ruby - Applying A/B testing on human relationships.

Copyright © 2014 Maxime Alay-Eddine @tarraschk - ARGAUS SAS Cybersecurity
http://www.argaus.fr

Licensed under the MIT license.

This script has been made to do a little social experiment, trying to apply A/B testing to Tinder.
Please do not abuse the Tinder community with this script. Try to meet girls in real life and preserve the dignity of human relationships.

# Requirements
A working Tinder account, connected to your Facebook account.
Ruby >= 1.9.3
MySQL server

# Usage

This script is an improvement of the previous TinderBot script.
Here, we will provide a complete UI to manage multiple Tinder Accounts, to share them between administrators.
This platform will be able to run of your own computer, or on a remote server :).

# Objectives

This project will allow:

* multiple Tinder accounts management
* automatic like
* customization of the like (pass if mutual friends)
* customization of the geographic localization
* automatic first message

# How to run it

First, setup your config files based on provided examples:
```
config/database.yml
config/environments/development.rb
config/environments/production.rb
```

Then, you have to prepare your gems:
```
bundle install
```

Now let's setup your database:
```
bundle exec rake db:setup
```

And launch the app:
```
bundle exec rails s
```

The default account is `test@test.com` with the password `azerty`.
