require File.expand_path( "../lib/rocket-chat-notifier/version", __FILE__ )

Gem::Specification.new do |s|

  s.name          = "rocket-chat-notifier"
  s.version       = RocketChat::Notifier::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = "A slim ruby wrapper for posting to Rocket.Chat webhooks"
  s.description   = %q{ A slim ruby wrapper for posting to Rocket.Chat webhooks }
  s.authors       = ["Thiago Felix"]
  s.email         = ["thiago@thiagofelix.com"]
  s.homepage      = "http://github.com/thiagofelix/rocket-chat-notifier"
  s.license       = "MIT"

  s.files         = Dir["{lib}/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"

end
