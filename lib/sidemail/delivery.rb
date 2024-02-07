require "sidemail/delivery/version"
require "sidemail/delivery/railtie"

module Sidemail
  module Delivery
    class << self
      attr_accessor :settings
    end

    def self.configure
      self.settings ||= Settings.new
      yield(settings)
    end

    class Settings
      attr_accessor :api_key
    end

    class Exception < StandardError
    end

    class Method
      URL = URI("https://api.sidemail.io/v1/email/send")

      def initialize(_options)
        # empty but unused, to avoid errors
      end

      def deliver!(mail)
        payload = {
          fromName: mail[:from].addrs.first.display_name,
          fromAddress: mail[:from].addrs.first.address,
          html: mail.html_part.decoded,
          text: mail.text_part.decoded,
          subject: mail[:subject]
        }
        if mail.attachments.size.positive?
          payload[:attachments] = mail.attachments.map do |attachment|
            {name: attachment.filename, content: Base64.strict_encode64(attachment.body.decoded)}
          end
        end

        response = post_to_api(mail[:to].addrs.map(&:address), payload)

        JSON.parse(response.body).tap do |json|
          break unless json.key?("errorCode")

          raise Sidemail::Delivery::Exception.new("#{json["errorCode"]}: #{json["developerMessage"]}")
        end
      rescue JSON::ParserError
        raise Sidemail::Delivery::Exception.new("Unable to parse response")
      end

      protected

      def post_to_api(addresses, payload)
        https = Net::HTTP.new(URL.host, URL.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(URL)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{Sidemail::Delivery.settings.api_key}"
        request.body = JSON.generate(addresses.map { |to| {toAddress: to}.merge(payload) })

        https.request(request)
      end
    end
  end
end
