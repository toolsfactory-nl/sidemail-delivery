require_relative "lib/sidemail/delivery/version"

Gem::Specification.new do |spec|
  spec.name = "sidemail-delivery"
  spec.version = Sidemail::Delivery::VERSION
  spec.authors = ["Frank Groeneveld"]
  spec.email = ["frank@toolsfactory.nl"]
  spec.homepage = "https://github.com/toolsfactory-nl/sidemail_delivery"
  spec.summary = "Rails delivery method for Sidemail."
  spec.description = "A Rails delivery method that uses the Sidemail transactional API for sending outgoing mail."
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0"
end
