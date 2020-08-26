require "fileutils"

module Minitest
  module Snapshots
    module TestExtensions
      def before_setup
        super
        @snapshot_assertion_counter = 0
        @snapshot_dir ||= if defined?(Rails)
                            Rails.root.join("test", "snapshots").to_s
                          elsif Dir.exist?("test")
                            File.expand_path("test/snapshots")
                          elsif Dir.exist?("spec")
                            File.expand_path("spec/snapshots")
                          else
                            File.expand_path("snapshots")
                          end
      end

      private

      def sanitize(name)
        sanitized = name.to_s.downcase.gsub(/(?:\A[\W_]+)|(?:[\W_]+\z)/, '').gsub(/[\W_]+/, '_')

        if sanitized.empty?
          raise NameError, "Can't sanitize name: #{name.inspect}"
        end

        sanitized
      end

      def snapshot_path(suite_name, snapshot_name)
        filename = "%s__%s.snap.yaml" % [sanitize(name), sanitize(snapshot_name)]
        subdir = sanitize(suite_name)
        File.join(@snapshot_dir, subdir, filename)
      end
    end
  end
end
