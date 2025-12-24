$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest"

# Minitest 5 loads plugins automatically, so the require is not needed in that case.
require "minitest/snapshots" unless Minitest::VERSION.to_i < 6

require "minitest/autorun"
