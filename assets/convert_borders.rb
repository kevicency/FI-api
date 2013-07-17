#!/usr/bin/env ruby
# The node xml libs have problems with KML :(

require 'rubygems'
require 'hpricot'
require 'json'

dir = File.dirname __FILE__
xml = File.read File.join(dir, 'borders_source.kml')
doc = Hpricot::XML(xml)

countries = {}
(doc/:Placemark).each do |placemark|
  borders = (placemark/:coordinates).map do |border|
    border.inner_text.gsub("\n", '').split(' ').map do |pair| 
      split = pair.split ','
      {
        longitude: split[0],
        latitude: split[1]
      }
    end
  end
  name = (placemark/:ExtendedData/'Data[@name="CNTRYNAME"]'/:value).inner_text.downcase
  countries[name] = borders
end

File.write File.join(dir, 'borders.json'), countries.to_json
