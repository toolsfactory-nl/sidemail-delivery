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

## Usage

After the installation your existing mailers will automatically send their html/text views through Sidemail. You might
need to contact Sidemail support to enable HTML sending through their API. 
They disable it by default to prevent abuse.

If you want to use templates you can modify your mailers to include the template name and properties in the mail call 
and pass an empty body to avoid the need for having a mailer view. For example:

```ruby
mail(to: "somebody@example.com", template: "my-template-name", template_props: { name: "Somebody" }, body: "")
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
