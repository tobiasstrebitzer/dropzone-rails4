# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropzone/version'

Gem::Specification.new do |spec|
  spec.name          = "dropzone-rails4"
  spec.version       = Dropzone::VERSION
  spec.authors       = ["Tobias Strebitzer"]
  spec.email         = ["tobias.strebitzer@gmail.com"]
  spec.description   = %q{dropzone.js Gem for Ruby on Rails 4}
  spec.summary       = %q{dropzone.js Rails 4}
  spec.homepage      = "https://github.com/tobiasstrebitzer/dropzone-rails4"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
