require_relative "snapshots"
require_relative "snapshots/version"

module Minitest
  def self.plugin_snapshots_options(opts, _options)
    Minitest::Snapshots.lock_snapshots = !ENV["CI"].to_s.empty?

    opts.on "-u", "--update-snapshots", "Update (overwrite) stored snapshots" do
      Minitest::Snapshots.force_updates = true
    end

    opts.on "-l", "--[no-]lock-snapshots", "Prevent any snapshots from being stored" do |bool|
      Minitest::Snapshots.lock_snapshots = bool
    end
  end

  def self.plugin_snapshots_init(_options)
    require_relative "snapshots/test_extensions"
    require_relative "snapshots/assertion_extensions"
    Minitest::Test.include Minitest::Snapshots::TestExtensions
  end
end
