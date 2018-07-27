$:.push File.expand_path("../lib", __FILE__)
require "stylet_support/version"

Gem::Specification.new do |s|
  s.name          = "stylet_support"
  s.version       = StyletSupport::VERSION
  s.summary       = "Vector library"
  s.description   = "Vector library"
  s.author        = "akicho8"
  s.homepage      = "http://github.com/akicho8/stylet_support"
  s.email         = "akicho8@gmail.com"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {s,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_development_dependency "test-unit"
end
