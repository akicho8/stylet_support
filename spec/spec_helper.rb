require "bundler/setup"
require "tapp"
require "stylet"

log_file = Pathname("#{__dir__}/../log/test.log").expand_path
FileUtils.makedirs(log_file.dirname)
Stylet.logger = ActiveSupport::Logger.new(log_file)

RSpec.configure do |config|
end
