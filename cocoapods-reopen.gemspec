# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-reopen/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-reopen'
  spec.version       = CocoapodsReopen::VERSION
  spec.authors       = ['dacaiguoguo']
  spec.email         = ['dacaiguoguo@gmail.com']
  spec.description   = %q{A short description of cocoapods-reopen.}
  spec.summary       = %q{A longer description of cocoapods-reopen.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-reopen'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.2.10'
  spec.add_development_dependency 'rake'
end
