require "pathname"
Pathname.glob("[0-9]*").sort.each{|file|
  p file.to_s
  system("rsdl #{file} --shutdown=60")
}
