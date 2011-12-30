#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "mail"

File.open(File.dirname(__FILE__) + '/mail.txt', 'w').write(STDIN.read)
