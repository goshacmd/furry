module Furry
  class App
    attr_reader :router

    # Initialize a new +App+.
    def initialize
      @router = Router.new
    end

    # (see Router#map)
    def map(method, path, handler = nil, &block)
      router.map(method, path, handler, &block)
    end

    # Process request.
    def call(env)
      method = env['REQUEST_METHOD'].to_sym
      path =  env['REQUEST_PATH']

      if handler = router.match(method, path)
        arity = handler.respond_to?(:arity) && handler.arity || 0
        arity == 0 ? handler.call : handler.call(env)
      else
        [404, {}, ['Route not found']]
      end
    end
  end
end
