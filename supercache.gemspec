# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'supercache/version'

Gem::Specification.new do |spec|
  spec.name          = "supercache"
  spec.version       = Supercache::VERSION
  spec.authors       = ['Bragadeesh J']
  spec.email         = ['bragboy@gmail.com']

  spec.summary       = %q{Speed up Development time}
  spec.description   = %q{SuperCache speeds up development time by caching recurring requests and lets you concentrate only on the objects you are changing/playing around with in a complete un-obtrusive manner}
  spec.homepage      = 'https://github.com/bragboy/supercache'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "appraisal"
end