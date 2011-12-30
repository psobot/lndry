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
message = Mail.read_from_string(email)

name = message[:from].to_s.split('<')[0].strip rescue nil
email_address = message[:from].addresses[0] rescue nil
to = message[:to]

`curl -d name=#{CGI.escape(name)} -d email=#{CGI.escape(email_address)} -d key=#{CGI.escape(INCOMING_EMAIL_KEY)} -d raw=#{CGI.escape(email)} -d to=#{CGI.escape(to.to_s)} http://#{HOST}/receive`
