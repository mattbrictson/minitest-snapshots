require "test_helper"

class Minitest::SnapshotsPluginTest < Minitest::Test
  def setup
    @orig_ci_value = ENV["CI"]
    @opt_parse = OptionParser.new
  end

  def teardown
    ENV["CI"] = @orig_ci_value
  end

  def test_does_not_lock_snapshots_by_default
    ENV["CI"] = nil
    register_plugin

    refute Minitest::Snapshots.lock_snapshots
  end

  def test_locks_snapshots_by_defaut_in_ci
    ENV["CI"] = "1"
    register_plugin

    assert Minitest::Snapshots.lock_snapshots
  end

  def test_lock_snapshots_can_be_disabled_in_ci_via_command_line_flag
    ENV["CI"] = "1"
    register_plugin
    @opt_parse.parse!(["--no-lock-snapshots"])

    refute Minitest::Snapshots.lock_snapshots
  end

  private

  def register_plugin
    Minitest.plugin_snapshots_options(@opt_parse, {})
  end
end
