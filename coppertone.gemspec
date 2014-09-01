# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coppertone/version'

Gem::Specification.new do |spec|
  spec.name          = 'coppertone'
  spec.version       = Coppertone::VERSION
  spec.authors       = ['Peter M. Goldstein']
  spec.email         = ['peter.m.goldstein@gmail.com']
  spec.summary       = 'A Sender Policy Framework (SPF) toolkit'
  spec.homepage      = 'https://github.com/petergoldstein/coppertone'
  spec.license       = 'Apache'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'i18n'
  spec.add_runtime_dependency 'addressable'
  spec.add_runtime_dependency 'activesupport'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_development_dependency 'rubocop'
end
