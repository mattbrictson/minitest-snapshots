module Minitest
  module Assertions
    def assert_matches_snapshot(string, snapshot_name = nil)
      snapshot_file = snapshot_path(snapshot_name || (@snapshot_assertion_counter += 1))

      if !Minitest::Snapshots.force_updates && File.exist?(snapshot_file)
        assert_equal File.read(snapshot_file), string, "The string does not match the snapshot (located at #{snapshot_file})"
      else
        if Minitest::Snapshots.lock_snapshots
          assert false, "New snapshot tried to be created when snapshot writing is prevented with the --lock-snapshots option."
        end
        File.open(snapshot_file, "w") do |file|
          file.write(string)
        end
      end
    end
  end
end
