module Furry
  class Controller
    attr_reader :params

    # Intitialize a new +Controller+.
    #
    # @param params [Hash] a hash of params
    def initialize(params)
      @params = HashWithIndifferentAccess.new params
    end

    # Render some text.
    def render(text, status: 200)
      [status, {}, [text]]
    end
  end
end
