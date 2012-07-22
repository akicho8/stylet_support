require "optparse"

module Stylet
  module ClOptions
    attr_reader :cl_options

    def initialize
      super
      @cl_options = {}
      oparser = OptionParser.new{|oparser|
        oparser.on("--shutdown=INTEGER", Integer){|v|@cl_options[:shutdown] = v}
      }
      oparser.parse(ARGV)
    end

    def update
      super
      if @cl_options[:shutdown] && @count >= @cl_options[:shutdown]
        throw :exit, :break
      end
    end
  end
end

if $0 == __FILE__
  require_relative "../stylet"
  ARGV << "--shutdown=60"
  Stylet::Base.main_loop
end
