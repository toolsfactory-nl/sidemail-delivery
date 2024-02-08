require "sidemail/delivery/exception"
require "sidemail/delivery/method"
require "sidemail/delivery/railtie"
require "sidemail/delivery/settings"
require "sidemail/delivery/version"

module Sidemail
  module Delivery
    class << self
      attr_accessor :settings
    end

    def self.configure
      self.settings ||= Settings.new
      yield(settings)
    end
  end
end
