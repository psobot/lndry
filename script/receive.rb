#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "mail"
require "cgi"

settings_file = File.expand_path('../config/settings.yml', File.dirname(__FILE__))
settings = YAML::load(File.open(settings_file))

env = if RUBY_PLATFORM.include?('darwin')
        'development'
      else
        'production'
      end
HOST = settings[env]['host']
INCOMING_EMAIL_KEY = settings[env]['incoming_email_key']

if env == 'production'
  email = STDIN.read
else
  email = File.open(File.dirname(__FILE__) + '/mail.txt').read
end

`curl -d key=#{CGI.escape(INCOMING_EMAIL_KEY)} -d raw=#{CGI.escape(email)} http://#{HOST}/receive`
