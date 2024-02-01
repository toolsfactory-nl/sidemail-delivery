module Sidemail
  module Delivery
    class Railtie < ::Rails::Railtie
      initializer "sidemail_delivery.configure_rails_initialization" do
        ActionMailer::Base.add_delivery_method :sidemail, Sidemail::Delivery::Method
      end
    end
  end
end
