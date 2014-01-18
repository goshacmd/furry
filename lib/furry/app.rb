module Furry
  class App
    class << self
      attr_reader :router

      # (see Router#map)
      def map(method, path, handler = nil, &block)
        router.map(method, path, handler, &block)
      end

      def inherited(base)
        super
        base.instance_variable_set(:@router, Router.new)
      end
    end

    delegate :router, to: :class

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
