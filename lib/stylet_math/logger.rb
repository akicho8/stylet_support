require "active_support/logger"
require "active_support/core_ext/module/attribute_accessors"

module StyletMath
  mattr_accessor :logger
  self.logger = ActiveSupport::Logger.new(STDOUT)
end

if $0 == __FILE__
  StyletMath.logger = ActiveSupport::Logger.new("#{__dir__}/../../log/development.log")
  StyletMath.logger.debug("OK")
end
