$KCODE = "u"
$LOAD_PATH.unshift(File.expand_path("#{File.dirname(__FILE__)}/lib"))
require "stylet"
Stylet.logger = ActiveSupport::BufferedLogger.new(File.expand_path(File.join(File.dirname(__FILE__), "log/test.log")))
