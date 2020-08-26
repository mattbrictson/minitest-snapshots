require "minitest/autorun"
require "minitest/assert_errors"
require_relative "../lib/minitest/snapshots"

class TestSnapshots < Minitest::Test
  def test_string_matches
    assert_matches_snapshot "foo"
  end

  def test_unmatching_string_raises
    assert_have_error(/does not match the snapshot/) do
      assert_matches_snapshot "foo"
    end
  end

  def test_hash_matches
    assert_matches_snapshot({ foo: "bar", baz: 1, qux: { foo: "corge" } })
  end

  def test_set
    assert_matches_snapshot(Set.new((0..100).sort_by { rand }))
  end
end
