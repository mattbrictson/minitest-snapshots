module Minitest::Snapshots
  class << self
    attr_accessor :force_updates
    attr_accessor :lock_snapshots
  end
end
