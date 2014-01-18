module Furry
  class Controller
    attr_reader :params

    # Intitialize a new +Controller+.
    #
    # @param params [Hash] a hash of params
    # @param query)params [Hash] a hash of query params
    def initialize(params, query_params)
      @params = HashWithIndifferentAccess.new query_params.merge(params)
    end

    # Render some text.
    def render(text, status: 200)
      [status, {}, [text]]
    end
  end
end
