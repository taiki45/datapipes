# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datapipes/version'

Gem::Specification.new do |spec|
  spec.name          = 'datapipes'
  spec.version       = Datapipes::VERSION
  spec.authors       = ['Taiki ONO']
  spec.email         = ['taiks.4559@gmail.com']
  spec.summary       = %q{An asynchronous multi steamings library.}
  spec.description   = %q{To handle multi steamings easily.}
  spec.homepage      = 'https://github.com/taiki45/datapipes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'parallel', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov', '~> 0.8'
  spec.add_development_dependency 'coveralls', '~> 0.7'
end
