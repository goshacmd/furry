module Furry
  # Furry application.
  #
  # @example basic application
  #   class DemoApp < Furry::App
  #     class HomeController < Controller
  #       def index
  #         render 'Hey there'
  #       end
  #     end
  #
  #     router.draw do
  #       get '/', 'home#index'
  #     end
  #   end
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

    TEMPLATES = {}

    # Find template by name.
    #
    # @param name [String] template name
    # @return [Array] a +(full_name,template)+ pair
    def find_template(name)
      TEMPLATES.find do |fn, _|
        fn == name || fn.split('.').first == name
      end
    end

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
      controller_class = lookup_controller(controller_name)
      controller = controller_class.new(self, params, query_params)
      controller.execute_action(action_name)
    end

    # Process request.
    #
    # @param env [Hash] environment hash
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
