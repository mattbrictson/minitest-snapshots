require "minitest"

module Minitest::Snapshots
  class << self
    attr_accessor :force_updates
    attr_accessor :lock_snapshots

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
