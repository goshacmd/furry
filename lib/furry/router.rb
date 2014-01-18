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
    # @param handler [String] controller & action (e.g. +'info#about'+)
    def map(method, path, handler)
      @mappings[[method, path]] = handler
    end

    def get(path, handler)
      map(:GET, path, handler)
    end

    def post(path, handler)
      map(:POST, path, handler)
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
