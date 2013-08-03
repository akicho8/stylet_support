$:.push File.expand_path("../lib", __FILE__)
require "stylet/version"

Gem::Specification.new do |s|
  s.name          = "stylet"
  s.version       = Stylet::VERSION
  s.summary       = "Simple SDL library"
  s.description   = "Simple SDL library"
  s.author        = "akicho8"
  s.homepage      = "http://github.com/akicho8/stylet"
  s.email         = "akicho8@gmail.com"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {s,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rsdl"
  s.add_dependency "rubysdl"

  s.add_dependency "activesupport"
  s.add_dependency "i18n"

  s.add_development_dependency "rspec"
  s.add_development_dependency "yard"
  s.add_development_dependency "tapp"
  s.add_development_dependency "pry-debugger"
end
