# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

washer = Type.create :name => "Washer", :slug => 'washer'
dryer = Type.create :name => "Dryer", :slug => 'dryer'

default_location = "VeloCity Laundry Room"
washer_duration = 2220  #seconds
dryer_duration = 3600   #seconds

Resource.create :location => default_location, :type_id => washer.id, :duration => washer_duration, :order => 1
Resource.create :location => default_location, :type_id => washer.id, :duration => washer_duration, :order => 2
Resource.create :location => default_location, :type_id => washer.id, :duration => washer_duration, :order => 3

Resource.create :location => default_location, :type_id => dryer.id, :duration => dryer_duration, :order => 1
Resource.create :location => default_location, :type_id => dryer.id, :duration => dryer_duration, :order => 2
Resource.create :location => default_location, :type_id => dryer.id, :duration => dryer_duration, :order => 3
