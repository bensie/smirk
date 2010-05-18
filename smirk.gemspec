Gem::Specification.new do |s|
  s.name = "smirk"
  s.version = "0.2.1"
  s.authors = ["James Miller"]
  s.date = "2010-05-18"
  s.summary = %q{Ruby wrapper for the SmugMug API}
  s.description = %q{Smirk is a simple Ruby wrapper for the SmugMug 1.2.2 API specification. It currently supports initiating a session, finding albums, images, and categories.}
  s.homepage = "http://github.com/bensie/smirk"
  s.email = "james@jk-tech.com"
  s.files  = %w( README.rdoc Rakefile LICENSE VERSION )
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("test/**/*")
  s.has_rdoc = false
  s.add_dependency("rest-client", ">= 1.5.1")
  s.add_dependency("json", ">= 1.4.3")
end

