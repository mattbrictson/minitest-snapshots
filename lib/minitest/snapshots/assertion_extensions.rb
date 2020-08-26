require_relative "serializer"
require "fileutils"

module Minitest
  module Assertions
    def assert_matches_snapshot(value, snapshot_name = nil)
      snapshot_file = snapshot_path(self.class.name, snapshot_name || (@snapshot_assertion_counter += 1))
      snapshot = Minitest::Snapshots::Serializer.serialize(value)

      if !Minitest::Snapshots.force_updates && File.exist?(snapshot_file)
        assert_equal File.read(snapshot_file), snapshot, "The value does not match the snapshot (located at #{snapshot_file})"
      else
        if Minitest::Snapshots.lock_snapshots
          assert false, "Attempt to create a snapshot failed because writing is prevented by the --lock-snapshots option"
        end

        FileUtils.mkdir_p(File.dirname(snapshot_file))
        File.write(snapshot_file, snapshot)
      end
    end
  end
end
