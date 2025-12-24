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

  module Snapshots
    class << self
      attr_accessor :force_updates, :lock_snapshots

      def default_snapshots_directory
        if defined?(Rails) && Rails.respond_to?(:root)
          Rails.root.join("test", "snapshots").to_s
        elsif Dir.exist?("test")
          File.expand_path("test/snapshots")
        elsif Dir.exist?("spec")
          File.expand_path("spec/snapshots")
        else
          File.expand_path("snapshots")
        end
      end
    end
  end
end
