class MusicArtistsLinkToad < LinkToad
  
  protected
  
  def hits_for_uri(uri)
    return [$2] if (uri=~%r[http://(www\.)?musicbrainz.org/artist/([-a-f0-9]{36})])
    return [$2] if (uri=~%r[http://(www\.)?bbc.co.uk/music/artists/([-a-f0-9]{36})])
    super
  end
end
