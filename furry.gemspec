# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'furry/version'

Gem::Specification.new do |spec|
  spec.name          = 'furry'
  spec.version       = Furry::VERSION
  spec.authors       = ['Gosha Arinich']
  spec.email         = ['me@goshakkk.name']
  spec.summary       = %q{Simplistic web framework}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'

  spec.add_dependency 'rack', '~> 1.4'
end
