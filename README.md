# Sidemail::Delivery
A Rails delivery method that uses the [Sidemail](https://sidemail.io) transactional API for sending outgoing mail.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "sidemail-delivery"
```

And then execute:
```bash
$ bundle
```

Create an initializer in `config/initializers/sidemail_delivery.rb` to configure your Sidemail API key:

```ruby
Sidemail::Delivery.configure do |config|
  config.api_key = "YOUR_API_KEY"
end
```

Now set your delivery method for your preferred environment, for example in `config/environments/production.rb`:

```ruby
Rails.application.configure do
  # ...
  config.action_mailer.delivery_method = :sidemail
  # ...
end
```

Finally you might need to contact Sidemail support to enable HTML sending through their API. 
They disable it by default to prevent abuse.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
