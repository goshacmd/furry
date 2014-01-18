module Furry
  module Container
    # Lookup class with name of +name+ and kind of +kind+.
    #
    # @example
    #   lookup(:info, :controller) # => InfoController
    #   lookup(:some_things, :view) # => SomeThingsView
    #
    # @param name [String, Symbol]
    # @param kind [String, Symbol]
    # @return [Class]
    def lookup(name, kind)
      const_get("#{name}_#{kind}".camelize)
    end

    # Lookup class for controller +name+.
    #
    # @param name [String, Symbol]
    # @return [Class]
    def lookup_controller(name)
      lookup(name, :controller)
    end
  end
end
