require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'yaml'

$: << File.expand_path(File.dirname(__FILE__))

class LinkToad
  attr_reader :mapping
  
  # +mapping+ is a hash mapping from a URL to an identifier
  # that should be associated with that URL.  
  def initialize(mapping)
    @mapping = mapping
  end
  
  # Returns the identifiers for the document at the given +url+.
  #
  # Identifiers are found by looking up links in the document in the +mapping+ hash.  
  def match(url)
    links = links_from_url(url)
    links.map { |l| hits_for_uri(l) }.flatten.uniq
  end
  
  protected
  
  def links_from_url(url)
    doc = Hpricot(open(url))
    links = []
    doc.search('//a').each do |link|
      next if link.attributes['href'].nil?
      begin
        uri = URI.parse(link.attributes['href'].strip)
      rescue URI::InvalidURIError
        next
      end
      next unless (uri.kind_of? URI::HTTP or uri.kind_of? URI::HTTPS)
      links << uri.to_s
    end
    links.uniq
  end
  
  def hits_for_uri(uri)
    # search for gids with both a trailing / and without
    uri_string = uri.gsub(%r[/$], '')
    uri_strings = [ uri_string, "#{uri_string}/" ]
    
    # search for gids with both 'www.' and without
    if uri_string =~ %r[http://www\.]
      uri_strings << uri_string.gsub('http://www.', 'http://')       
    else
      uri_strings << uri_string.gsub('http://', 'http://www.') 
    end
    uri_strings << "#{uri_strings.last}/"    
    
    # try also without the index.* if it has one
    uri_strings << uri_string.sub(/index\.\w{3,4}/i, '') if uri_string =~ /index\.\w{3,4}$/i
    
    uri_strings.map { |u| @mapping[u] }.flatten.compact.uniq
  end
end
