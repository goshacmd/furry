module Furry
  class Controller
    module Rendering
      CONTENT_TYPES = {
        'text' => 'text/plain',
        'html' => 'text/html'
      }

      # @overload render(text: nil, status: 200)
      #   Render some text.
      #   @param text [String] text to render
      #   @param status [Integer] status code
      #
      # @overload render(erb: nil, status: 200)
      #   Render inline ERB template.
      #   @param erb [String] inline erb template
      #   @param status [Integer] status code
      #
      # @overload render(template: nil, status: 200)
      #   Render ERB template.
      #   @param template [String] template name
      #   @param status [Integer] status code
      def render(text: nil, erb: nil, template: nil, status: 200)
        self._status = status

        if text
          self._body = text
          self._headers['Content-Type'] = 'text/plain'
        elsif erb
          self._body = ERB.new(erb).result(binding)
          self._headers['Content-Type'] = 'text/html'
        elsif template
          full_temp_name, temp = @app.find_template(template)
          content_type, body = Template.new(full_temp_name, temp).render(binding)

          self._body = body
          self._headers['Content-Type'] = CONTENT_TYPES[content_type]
        end
      end
    end
  end
end
