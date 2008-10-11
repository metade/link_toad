require 'rubygems'
require 'rss/2.0'
require 'yaml'
require '../../../lib/link_toad.rb'

mapping = YAML.load_file('guardian-musicbrainz.yml')
toad = LinkToad.new(mapping)

feed = RSS::Parser.parse(open('http://www.guardian.co.uk/music/rss'))
feed.items.each do |item|
  url = item.guid.content
  gids = toad.match(url)
  puts "#{url}: #{gids.inspect}"
end

