# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compositor/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "compositor-rails"
  spec.version       = Compositor::Rails::VERSION
  spec.authors       = ["Paul Henry"]
  spec.email         = ["paul@wanelo.com"]
  spec.summary       = %q{ActionView extensions to compositor.}
  spec.description   = %q{VIEWS WITH COMPOSITOR YAY}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'compositor'
  spec.add_dependency 'activesupport', '>= 3.0.0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "actionpack"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "railties"
end
