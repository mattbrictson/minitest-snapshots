module Minitest
  module Snapshots
    module TestExtensions
      def before_setup
        super
        @snapshot_assertion_counter = 0
        @snapshot_dir ||= Rails.root.join("test", "snapshots").to_s
      end

      private

      def snapshot_path(snapshot_name)
        File.join(@snapshot_dir, "#{name}__#{snapshot_name}.snap.txt")
      end
    end
  end
end
