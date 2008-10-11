require 'rubygems'
require 'hpricot'
require 'rbrainz'
require 'open-uri'
require 'yaml'

file = File.open('guardian-musicbrainz.yml', 'w')
file.puts('---')

ignore_list = [
  # guardian specific
  /alternativetop100albums/, /bobmarley60thanniversary/,
  # events
  /britawards/, /eurovision/, /glastonbury/, /live8/, /meltdownfestival/, 
  /mercuryprize/, /o2wirelessweekenders/, /proms/, /readingandleedsfestival/, 
  # genres
  /classicalmusicandopera/, /downloads/, /electronicmusic/, /folk/, 
  /jazz/, /popandrock/, /worldmusic/
]

urls = []
q = MusicBrainz::Webservice::Query.new
doc = Hpricot(open('http://www.guardian.co.uk/music/list/allmusickeywords'))
doc.search('//a').each do |link|
  url = link.attributes['href']
  next if url.nil?
  next if urls.include? url
  next unless url =~ %r[http://www.guardian.co.uk/music/(\w+)$]
  next if ignore_list.detect { |re| url =~ re }
  urls << url

  name = link.inner_html.strip
  results = q.get_artists(MusicBrainz::Webservice::ArtistFilter.new(:query => name))
  sleep 1 # don't hit MusicBrainz too hard
  
  if results.size>0
    m_name, gid = results[0].entity.name, results[0].entity.id.uuid
    file.puts("#{url}: #{gid} ##{m_name}")
  end
end
