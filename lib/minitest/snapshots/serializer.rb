require 'set'
require 'yaml'

module Minitest
  module Snapshots
    # The serializer translates values (objects) into strings. By default,
    # it uses YAML (Psych). Can be overridden to implement custom
    # serialization formats, e.g.:
    #
    #  module Minitest::Snapshots::Serializer
    #    def self.serialize(value)
    #      Marshal.dump(value)
    #    end
    #  end
    module Serializer
      # The name of the method used to customize the output of +to_yaml+.
      # Used to provide canonical representations for Hash and Set instances.
      HOOK = :encode_with

      # Used to ensure the addition/removal of hooks is atomic
      @lock = Mutex.new

      # Serialize the supplied value to YAML with hooks to canonicalize
      # (i.e. sort) Hash keys and Set elements.
      #
      #   h1 = { foo: "bar", baz: "quux" }
      #   h2 = { baz: "quux", foo: "bar" }
      #
      #   h1.to_yaml == h2.to_yaml                             # => false
      #   Serializer.serialize(h1) == Serializer.serialize(h2) # => true
      #
      # The hooks are only installed for the duration of the method call
      # and are not installed if custom hooks are already defined.
      def self.serialize(value)
        @lock.synchronize do
          begin
            if (hook_hash = hook?(Hash))
              Hash.define_method(HOOK) do |coder|
                sorted = sort_by { |pair| pair.first.to_yaml }.to_h
                coder.map = dup.clear.merge!(sorted)
              end
            end

            if (hook_set = hook?(Set))
              Set.define_method(HOOK) do |coder|
                sorted = sort_by(&:to_yaml)
                coder.seq = dup.clear.merge(sorted)
              end
            end

            value.to_yaml
          ensure
            Hash.remove_method(HOOK) if hook_hash
            Set.remove_method(HOOK) if hook_set
          end
        end
      end

      # Returns true if a class is hookable (doesn't already have a YAML
      # serialization hook defined), false otherwise
      def self.hook?(mod)
        !(mod.method_defined?(HOOK) || mod.private_method_defined?(HOOK))
      end

      private_class_method :hook?
    end
  end
end
