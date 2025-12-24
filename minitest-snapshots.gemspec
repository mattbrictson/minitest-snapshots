require_relative "lib/minitest/snapshots/version"

Gem::Specification.new do |spec|
  spec.name = "minitest-snapshots"
  spec.version = Minitest::Snapshots::VERSION
  spec.authors = ["Harry Brundage", "Matt Brictson"]
  spec.email = ["harry.brundage@gmail.com", "opensource@mattbrictson.com"]

  spec.summary = "Minitest plugin implementing Jest-style snapshot testing"
  spec.homepage = "https://github.com/mattbrictson/minitest-snapshots"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/mattbrictson/minitest-snapshots/issues",
    "changelog_uri" => "https://github.com/mattbrictson/minitest-snapshots/releases",
    "source_code_uri" => "https://github.com/mattbrictson/minitest-snapshots",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest", ">= 5"
end
