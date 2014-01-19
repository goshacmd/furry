module Furry
  class Controller
    include UrlHelpers

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

    # @overload render(text: nil, status: 200)
    #   Render some text.
    #   @param text [String] text to render
    #   @param status [Integer] status code
    #
    # @overload render(erb: nil, status: 200)
    #   Render ERB template.
    #   @param erb [String] inline erb template
    #   @param status [Integer] status code
    def render(text: nil, erb: nil, status: 200)
      self._status = status

      if text
        self._body = text
      elsif erb
        self._body = ERB.new(erb).result(binding)
      end
    end

    # Redirect the browser to +location+.
    #
    # @param location [String]
    # @param status [Integer] status code
    def redirect_to(location, status: 302)
      self._status = status
      self._headers['Location'] = location
      self._body = ''
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
