Gem::Specification.new do |spec|
  spec.name = "stylet"
  spec.version = "0.1.0"
  spec.summary = "Simple SDL library"
  spec.description = "Simple SDL library (hobo jibun senyou)"
  spec.author = "akicho8"
  spec.homepage = "http://github.com/akicho8/stylet"
  spec.email = "akicho8@gmail.com"
  spec.email = "akicho8@gmail.com"
  spec.files = %x[git ls-files].scan(/\S+/)
  spec.rdoc_options = ["--line-numbers", "--inline-source", "--charset=UTF-8", "--diagram", "--image-format=jpg"]
  spec.executables = ["stylet"]
  spec.platform = Gem::Platform::RUBY
  spec.add_dependency("activesupport")
  spec.add_dependency("rspec")
  spec.add_dependency("rsdl")
  spec.add_dependency("rubysdl")
end
