#!/usr/bin/env ruby

require 'time'
require 'uri'
require 'net/http'
require 'JSON'
require 'byebug'

fname = 'events.yml'
eventfile = File.open(fname, 'w')

t = Time.new.xmlschema
tt = t.to_s[0..-7] + 'Z'

uri_str = 'https://www.eventbriteapi.com/v3/events/search/?organizer.id=8929654067&start_date.range_start='
uri_str += tt + '&token=MUEJI37ZIE226V4SSGIW'
uri = URI(uri_str)

byebug
resp = Net::HTTP.get(uri)

j = JSON.parse(resp)

y = j.to_yaml

eventfile.puts y
eventfile.close
