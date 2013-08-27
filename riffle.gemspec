# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riffle/version'

Gem::Specification.new do |spec|
  spec.name          = "riffle"
  spec.version       = Riffle::VERSION
  spec.authors       = ["Jordan Stephens"]
  spec.email         = ["iam@jordanstephens.net"]
  spec.description   = %q{defines Array#riffle to merge multiple arrays as if riffling a deck of cards. }
  spec.summary       = %q{riffle multiple Arrays by selecting a random number of items from each and appending to a new result Array until all arugment Arrays are empty and all elements have been merged. }
  spec.homepage      = "http://github.com/jordanstephens/riffle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
