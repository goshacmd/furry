module Furry
  class Controller
    autoload :Rendering,   'furry/controller/rendering'
    autoload :Redirecting, 'furry/controller/redirecting'

    include UrlHelpers
    include Rendering
    include Redirecting

    attr_reader :params
    attr_accessor :_status, :_headers, :_body

    delegate :action_methods, to: :class

    # Intitialize a new +Controller+.
    #
    # @param app [App] application
    # @param params [Hash] a hash of params
    # @param query_params [Hash] a hash of query params
    def initialize(app, params = {}, query_params = {})
      @app = app
      @params = HashWithIndifferentAccess.new query_params.merge(params)
      @_headers = {}
    end

    # @return [Router]
    def router
      @app.router
    end

    # Get rack response.
    def _rack_response
      [_status, _headers, [_body]]
    end

    # Execute an action.
    #
    # @param action_name [String]
    def execute_action(action_name)
      unless action_methods.include? action_name.to_sym
        raise ArgumentError,
          "Invalid action name: #{action_name} on controller #{self.class.name}"
      end

      send(action_name)
      _rack_response
    end

    # Compute a list of valid actions.
    def self.action_methods
      public_instance_methods - Controller.public_instance_methods
    end
  end
end
