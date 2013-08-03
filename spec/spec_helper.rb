$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stylet'

Stylet.logger = ActiveSupport::Logger.new("#{__dir__}/../log/test.log")

RSpec.configure do |config|
end
