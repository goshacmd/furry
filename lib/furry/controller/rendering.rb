module Furry
  class Controller
    module Rendering
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
          self._headers['Content-Type'] = 'text/plain'
        elsif erb
          self._body = ERB.new(erb).result(binding)
          self._headers['Content-Type'] = 'text/html'
        end
      end
    end
  end
end
