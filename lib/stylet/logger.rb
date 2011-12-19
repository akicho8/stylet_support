require "active_support/buffered_logger"
require "active_support/core_ext/module/attribute_accessors"

module Stylet
  mattr_accessor :logger

  module Logger
    def initialize(*)
      super if defined? super
      unless Stylet.logger
        Stylet.logger = ActiveSupport::BufferedLogger.new(STDOUT)
      end
    end

    def logger
      Stylet.logger
    end
  end
end

if $0 == __FILE__
  Stylet.logger = ActiveSupport::BufferedLogger.new(File.expand_path(File.join(File.dirname(__FILE__), "../../log/development.log")))
  Stylet.logger.debug("OK")
end
