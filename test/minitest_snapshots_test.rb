require "test_helper"

class TestSnapshots < Minitest::Test
  def test_string_matches
    assert_matches_snapshot "foo"
  end

  def test_unmatching_string_raises
    error = assert_raises(Minitest::Assertion) do
      assert_matches_snapshot "foo"
    end

    assert_match(/does not match the snapshot/, error.message)
  end

  def test_hash_matches
    assert_matches_snapshot({foo: "bar", baz: 1, qux: {foo: "corge"}})
  end

  def test_set
    assert_matches_snapshot(Set.new((0..100).sort_by { rand }))
  end

  def test_default_snapshots_directory
    assert_equal(File.expand_path("snapshots", __dir__), Minitest::Snapshots.default_snapshots_directory)
  end

  def test_default_snapshots_directory_uses_rails_root_if_defined
    with_rails_module_stub do
      Rails.define_singleton_method(:root) { Pathname.new("/path/to/rails/root") }
      assert_equal("/path/to/rails/root/test/snapshots", Minitest::Snapshots.default_snapshots_directory)
    end
  end

  def test_default_snapshots_directory_ignores_rails_if_root_is_undefined
    with_rails_module_stub do
      assert_equal(File.expand_path("snapshots", __dir__), Minitest::Snapshots.default_snapshots_directory)
    end
  end

  private

  def with_rails_module_stub
    Object.const_set :Rails, Module.new
    yield
  ensure
    Object.send(:remove_const, :Rails)
  end
end
