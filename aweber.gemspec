# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name         = "aweber"
  s.version      = "1.1.0"
  s.platform     = Gem::Platform::RUBY
  s.summary      = "Ruby interface to AWeber's API"
  s.description  = "Ruby interface to AWeber's API"
  
  s.author       = "AWeber Communications, Inc."
  s.email        = "help@aweber.com"
  s.homepage     = "http://github.com/aweber/AWeber-API-Ruby-Library"
  
  s.require_path = "lib"
  s.files        = [
    "aweber.gemspec",
    "examples/with_access_token.rb",
    "examples/your_account.rb",
    "Gemfile",
    "Gemfile.lock",
    "lib/aweber.rb",
    "lib/aweber/base.rb",
    "lib/aweber/collection.rb",
    "lib/aweber/oauth.rb",
    "lib/aweber/resource.rb",
    "lib/aweber/resources.rb",
    "lib/aweber/resources/account.rb",
    "lib/aweber/resources/broadcast.rb",
    "lib/aweber/resources/click.rb",
    "lib/aweber/resources/followup.rb",
    "lib/aweber/resources/integration.rb",
    "lib/aweber/resources/link.rb",
    "lib/aweber/resources/list.rb",
    "lib/aweber/resources/message.rb",
    "lib/aweber/resources/open.rb",
    "lib/aweber/resources/subscriber.rb",
    "lib/aweber/resources/tracked_event.rb",
    "lib/aweber/resources/web_form.rb",
    "lib/aweber/resources/web_form_split_test.rb",
    "lib/aweber/resources/web_form_split_test_component.rb",
    "LICENSE",
    "Rakefile",
    "README.textile",
  ]
  
  s.test_files   = Dir["spec/**/*"]
  s.extra_rdoc_files = ["LICENSE", "README.textile"]

  s.add_dependency "oauth"
  
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "rspec", "~> 2.1.0"
  s.add_development_dependency "yard",  "~> 0.6.0"
end

