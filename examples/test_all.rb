require "pathname"
Pathname.glob("[0-9]*").sort.each do |file|
  puts "#{"-" * 70} #{file}"
  system("rsdl #{file} --shutdown=60")
end

