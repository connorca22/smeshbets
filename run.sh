#!/bin/bash

#install bundler gem
gem install bundler

# #install gems required for the app 
bundle install

clear

#run the application 
ruby src/index.rb