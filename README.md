# Minitest::Snapshots

Simple minitest plugin gem implementing Jest style snapshot testing. It's like VCR, but for any string.

## Usage

Instead of copying and pasting large segments of machine generated text into your test files, and updating them all the time, assert against a snapshot managed by this library. The first time the snapshot assertion is run it will write the value to disk, and then then next time, it will check against that value.

Example:

```ruby
class QueryCompilerText extends Minitest::Test
    def test_it_can_compile_a_query
        assert_matches_snapshot QueryCompiler.new.compile
    end
end
```

## Command line options

* `-u` or `--update-snapshots`: Update snapshots on disk to the new actual value when re-running the test. Useful when you know the new output of a test case is correct and the snapshot is out of date.
* `-l` or `--lock-snapshots`: Prevents new snapshots from being written. Useful on CI to ensure all snapshots have been written by the developer.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-snapshots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-snapshots


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/superpro-inc/minitest-snapshots. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Minitest::Snapshots project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/superpro-inc/minitest-snapshots/blob/master/CODE_OF_CONDUCT.md).
