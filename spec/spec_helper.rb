require "bundler/setup"
require "tapp"
require "stylet"

Stylet.logger = ActiveSupport::BufferedLogger.new(File.expand_path(File.join(File.dirname(__FILE__), "log/test.log")))
RSpec.configure do |config|
end
