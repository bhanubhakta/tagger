$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tagger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tagger"
  s.version     = Tagger::VERSION
  s.authors     = ["Bhanu Bhakta Sigdel"]
  s.email       = ["bsbhanu169@gmail.com"]
  s.homepage    = ""
  s.summary     = "Tagger gem to tag entities."
  s.description = "Tagger gem to tag entities. It is a simple pluggable app to tag any entities."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
