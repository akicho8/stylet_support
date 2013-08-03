require "active_support/logger"
require "active_support/core_ext/module/attribute_accessors"

module Stylet
  mattr_accessor :logger
  self.logger = ActiveSupport::Logger.new(STDOUT)
end

if $0 == __FILE__
  Stylet.logger = ActiveSupport::Logger.new("#{__dir__}/../../log/development.log")
  Stylet.logger.debug("OK")
end
