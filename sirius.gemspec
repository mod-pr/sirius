# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sirius/version'

Gem::Specification.new do |spec|
  spec.name          = "sirius"
  spec.version       = Sirius::VERSION
  spec.authors       = ["mod-pr"]
  spec.email         = ["mod.pr@yandex.ru"]
  spec.description   = %q{api for 2ch.hk}
  spec.summary       = %q{api for 2ch.hk}
  spec.homepage      = "https://github.com/mod-pr/sirius"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.10"

  spec.add_dependency "json", "~> 1.7.7"
end
