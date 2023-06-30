require_relative "snapshots"
require_relative "snapshots/version"

module Minitest
  def self.plugin_snapshots_options(opts, _options)
    opts.on "-u", "--update-snapshots", "Update (overwrite) stored snapshots" do
      Minitest::Snapshots.force_updates = true
    end

    opts.on "-l", "--lock-snapshots", "Prevent any snapshots from being stored" do
      Minitest::Snapshots.lock_snapshots = true
    end
  end

  def self.plugin_snapshots_init(_options)
    require_relative "snapshots/test_extensions"
    require_relative "snapshots/assertion_extensions"
    Minitest::Test.send :include, Minitest::Snapshots::TestExtensions
  end
end
