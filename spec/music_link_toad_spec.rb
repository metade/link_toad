require File.join(File.dirname(__FILE__), 'spec_helper')

require 'link_toad/music_link_toad'

describe MusicArtistsLinkToad do
  before(:each) do
    @toad = MusicArtistsLinkToad.new({})
  end
  
  describe "looking up gids for a uri" do

    it "should match a BBC Artist URL" do
      [ 'http://bbc.co.uk/music/artists/cc197bad-dc9c-440d-a5b5-d52ba2e14234',
        'http://bbc.co.uk/music/artists/cc197bad-dc9c-440d-a5b5-d52ba2e14234/',
        'http://www.bbc.co.uk/music/artists/cc197bad-dc9c-440d-a5b5-d52ba2e14234',
        'http://www.bbc.co.uk/music/artists/cc197bad-dc9c-440d-a5b5-d52ba2e14234/',
      ].each { |uri| @toad.send(:hits_for_uri, uri).should == [ 'cc197bad-dc9c-440d-a5b5-d52ba2e14234' ] }
    end
    
    it "should match a MusicBrainz URL" do
      [ 'http://musicbrainz.org/artist/cc197bad-dc9c-440d-a5b5-d52ba2e14234',
        'http://musicbrainz.org/artist/cc197bad-dc9c-440d-a5b5-d52ba2e14234/',
        'http://www.musicbrainz.org/artist/cc197bad-dc9c-440d-a5b5-d52ba2e14234',
        'http://www.musicbrainz.org/artist/cc197bad-dc9c-440d-a5b5-d52ba2e14234/',
      ].each { |uri| @toad.send(:hits_for_uri, uri).should == [ 'cc197bad-dc9c-440d-a5b5-d52ba2e14234' ] }
    end
  end
end
