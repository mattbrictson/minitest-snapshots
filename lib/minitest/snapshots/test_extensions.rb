require "fileutils"

module Minitest
  module Snapshots
    module TestExtensions
      def before_setup
        super
        @snapshot_assertion_counter = 0
        @snapshot_dir ||= if defined?(Rails)
                            Rails.root.join("test", "snapshots").to_s
                          else
                            FileUtils.pwd
                          end
      end

      private

      def snapshot_path(suite_name, snapshot_name)
        File.join(@snapshot_dir, suite_name, "#{name}__#{snapshot_name}.snap.txt")
      end
    end
  end
end
