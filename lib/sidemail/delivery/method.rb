# frozen_string_literal: true

module Sidemail
  module Delivery
    class Method
      URL = URI("https://api.sidemail.io/v1/email/send")

      def initialize(_options)
        # empty but unused, to avoid errors
      end

      def deliver!(mail)
        response = post_to_api(mail[:to].addrs.map(&:address) + mail[:cc]&.addrs.to_a.map(&:address) +
          mail[:bcc]&.addrs.to_a.map(&:address), payload(mail))
        JSON.parse(response.body).tap do |json|
          break if json.is_a?(Array) # successful mail to multiple addresses
          break unless json.key?("errorCode")

          raise Sidemail::Delivery::Exception.new("#{json["errorCode"]}: #{json["developerMessage"]}")
        end
      rescue JSON::ParserError
        raise Sidemail::Delivery::Exception.new("Unable to parse response")
      end

      protected

      def payload(mail)
        result = {
          fromName: mail[:from].addrs.first.display_name,
          fromAddress: mail[:from].addrs.first.address
        }
        result[:subject] = mail[:subject] if mail[:subject].present?
        if mail[:template].present?
          result[:templateName] = mail[:template]
          result[:templateProps] = mail[:template_props].unparsed_value
        else
          result[:html] = mail.html_part.decoded
          result[:text] = mail.text_part.decoded
        end
        if mail.attachments.size.positive?
          result[:attachments] = mail.attachments.map do |attachment|
            {name: attachment.filename, content: Base64.strict_encode64(attachment.body.decoded)}
          end
        end
        result
      end

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
