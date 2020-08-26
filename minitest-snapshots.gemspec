lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "minitest/snapshots/version"

Gem::Specification.new do |spec|
  spec.name = "minitest-snapshots"
  spec.version = Minitest::Snapshots::VERSION
  spec.authors = ["Harry Brundage"]
  spec.email = ["harry.brundage@gmail.com"]

  spec.summary = %q{Minitest plugin implementing Jest-style snapshot testing}
  spec.homepage = "https://github.com/superpro-inc/minitest-snapshots"
  spec.license = "MIT"

  spec.files = `git ls-files -z *.md *.txt lib`.split("\0")
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.14.1"
  spec.add_development_dependency "minitest-assert_errors"
end
