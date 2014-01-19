module Furry
  # Application router.
  #
  # @example
  #   router = Router.new
  #   router.draw do
  #     get '/', 'home#index'
  #   end
  class Router
    attr_reader :mappings, :names

    # Initialize a new +Router+.
    def initialize
      @mappings = Hash.new { |h, k| h[k] = [] }
      @names = {}
    end

    # Map a handler to (method,path) pair. Pass either a proc or a
    # block.
    #
    # @param method [Symbol] request method (+:GET+, +:POST+, etc)
    # @param path [String]
    # @param handler [String] controller & action (e.g. +'info#about'+)
    # @param name [String] route name
    def map(method, path, handler, name: nil)
      route = Route.new(method, path, handler)
      @names[name] = route if name
      @mappings[method] << route
    end

    # Map a GET request handler to path.
    #
    # @see #map
    def get(*args)
      map(:GET, *args)
    end

    # Map a post request handler to path.
    #
    # @see #map
    def post(path, *args)
      map(:POST, *args)
    end

    # Find a route handler.
    #
    # @param method [Symbol] request method
    # @param path [String]
    #
    # @return [Array] array of +(handler,params)+
    def match(method, path)
      route = @mappings[method].find { |r| r.matches?(path) }
      route.match(path)
    end

    # Draw on the router.
    #
    # Just executes the block in the context of router.
    def draw(&block)
      instance_exec(&block)
    end
  end
end
