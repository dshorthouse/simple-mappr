$:.push File.expand_path("../lib", __FILE__)

require "simple-mappr/version"

Gem::Specification.new do |s|
  s.name        = 'simple-mappr'
  s.version     = SimpleMappr::VERSION
  s.license     = 'MIT'
  s.date        = '2016-08-24'
  s.summary     = "A gem to access the SimpleMappr API"
  s.description = "A gem to access the SimpleMappr API"
  s.authors     = ["David P. Shorthouse"]
  s.email       = 'davidpshorthouse@gmail.com '
  s.homepage    = 'https://github.com/dshorthouse/simple-mappr'

  s.files        = Dir['MIT-LICENSE', 'README.rdoc', 'lib/**/*']
  s.require_path = 'lib'
  s.rdoc_options.concat ['--encoding',  'UTF-8']
  s.add_runtime_dependency "rest-client", "~> 2.0"
  s.add_development_dependency "rake", "~> 11.1"
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "byebug", "~> 9.0"
end