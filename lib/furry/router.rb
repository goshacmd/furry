module Furry
  class Router
    def initialize
      @mappings = {}
    end

    # Map a handler to (method,path) pair. Pass either a proc or a
    # block.
    #
    # @param method [Symbol] request method (+:GET+, +:POST+, etc)
    # @param path [String]
    # @param handler [#call] route handler
    # @param block [Proc] route handler
    def map(method, path, handler = nil, &block)
      @mappings[[method, path]] = handler || block
    end

    # Find a route handler.
    #
    # @param method [Symbol] request method
    # @param path [String]
    #
    # @return [#call]
    def match(method, path)
      @mappings[[method, path]]
    end
  end
end
