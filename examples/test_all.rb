require "pathname"
Pathname.glob("[0-9]*").sort.each{|file|
  p file
  system("rsdl #{file} --shutdown=60")
}
