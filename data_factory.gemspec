# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_factory/version'

Gem::Specification.new do |spec|
  spec.name          = "data_factory"
  spec.version       = DataFactory::VERSION
  spec.authors       = ["robertomiranda", "rfrm"]
  spec.email         = ["rjmaltamar@gmail.com", "rfrodriguez1992@gmail.com"]
  spec.description   = %q{Ruby Client for DataFactory Service}
  spec.summary       = %q{Ruby Client for DataFactory Service}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'simplecov'

  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'virtus'
  spec.add_runtime_dependency 'activesupport', '~> 4.1'
  spec.add_runtime_dependency 'typhoeus'
end
