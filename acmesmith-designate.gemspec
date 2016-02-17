# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acmesmith-designate/version'

Gem::Specification.new do |spec|
  spec.name          = 'acmesmith-designate'
  spec.version       = AcmesmithDesignate::VERSION
  spec.authors       = ['Kasumi Hanazuki']
  spec.email         = ['kasumi@rollingapple.net']

  spec.summary       = %q{acmesmith plugin implementing dns-01 using OpenStack Designate}
  spec.description   = %q{This gem is a plugin for acmesmith and implements an automated dns-01 challenge responder using OpenStack Designate.}
  spec.homepage      = 'https://github.com/hanazuki/acmesmith-designate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split(?\0).reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'acmesmith'
  spec.add_dependency 'yao-designate'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
