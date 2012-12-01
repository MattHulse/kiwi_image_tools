# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kiwi_image_tools/version'

Gem::Specification.new do |gem|
  gem.name          = "kiwi_image_tools"
  gem.version       = KiwiImageTools::VERSION
  gem.authors       = ["Matt Hulse"]
  gem.email         = ["matt.hulse@gmail.com"]
  gem.description   = %q{Generate an image based on input}
  gem.summary       = ""
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rmagick"
end
