# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hashnest/version'

Gem::Specification.new do |spec|
  spec.name          = "hashnest"
  spec.version       = HashNest::VERSION
  spec.authors       = ["charls","yin"]
  spec.email         = ["changxin.yin@bitmain.com"]
  spec.description   = "Gem for acsess to api HashNest"
  spec.summary       = "HashNest api library"
  spec.homepage      = "https://bitbucket.org/cd-bitmain/hashnest-api"
  spec.license       = "MIT"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "rr"

  spec.add_dependency "addressable"

end
