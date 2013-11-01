$:.push File.expand_path("../lib", __FILE__)
require "stylet_math/version"

Gem::Specification.new do |s|
  s.name          = "stylet_math"
  s.version       = StyletMath::VERSION
  s.summary       = "Simple Vector library"
  s.description   = "Simple Vector library"
  s.author        = "akicho8"
  s.homepage      = "http://github.com/akicho8/stylet_math"
  s.email         = "akicho8@gmail.com"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {s,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_development_dependency "rspec"
end
