Gem::Specification.new do |s|
  s.name     = "link_toad"
  s.version  = "0.0.1"
  s.date     = "2008-10-11"
  s.summary  = "LinkToad: hyperlink-powered equivalency engine."
  s.email    = "metade@gmail.com"
  s.homepage = "http://github.com/metade/link_toad"
  s.description = "LinkToad is a general purpose equivalency engine that uses hyperlinks."
  s.has_rdoc = true
  s.authors  = ["Patrick Sinclair"]
  s.files    = [
    "README",
    "lib/link_toad.rb",
    "examples/musicbrainz/guardian/README",
    "examples/musicbrainz/guardian/guardian-music-news.rb",
    "examples/musicbrainz/guardian/guardian-musicbrainz.rb",
    "examples/musicbrainz/guardian/guardian-musicbrainz.yml"
  ]
  s.test_files = [
    "spec/link_toad_spec.rb"
  ]
  s.rdoc_options = ["--main", "README", "-x example*"]
  s.extra_rdoc_files = ["README"]
  s.add_dependency("hpricot", ["> 0.0.0"])
end