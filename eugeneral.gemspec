# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eugeneral/version'

Gem::Specification.new do |spec|
  spec.name          = "eugeneral"
  spec.version       = Eugeneral::VERSION
  spec.authors       = ["Eugene Westbrook"]
  spec.email         = ["eugenewestbrook@gmail.com"]
  spec.summary       = 'Simple rules engine.'
  spec.description   = 'Simple rules engine.'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'factory_girl', '~> 4.5'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'heredoc_unindent', '~> 1.2'
  spec.add_development_dependency 'guard', '~> 2.13'
  spec.add_development_dependency 'guard-rspec', '~> 4.6'
end
