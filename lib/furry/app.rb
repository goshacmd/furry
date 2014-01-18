module Furry
  class App
    extend Container

    Controller = Controller

    class << self
      attr_reader :router

      def inherited(base)
        super
        base.instance_variable_set(:@router, Router.new)
      end
    end

    delegate :router, :lookup_controller, to: :class

    # Call a controller action.
    #
    # @param handler [String] a string of form
    #   +controller_name#action_name+, e.g. +info#about+
    # @param params [Hash] a params hash
    # @param query_params [Hash] a query params hash
    #
    # @return [Array] rack response
    def call_action(handler, params, query_params)
      controller_name, action_name = handler.split('#')
      controller = lookup_controller(controller_name)
      controller.new(params, query_params).send(action_name)
    end

    # Process request.
    def call(env)
      method = env['REQUEST_METHOD'].to_sym
      path = env['REQUEST_PATH']
      query_params = CGI.parse(env['QUERY_STRING']).map { |k, v| [k, v.first] }.to_h
      if match = router.match(method, path)
        call_action(*match, query_params)
      else
        [404, {}, ['Route not found']]
      end
    end
  end
end
