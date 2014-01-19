module Furry
  class Controller
    module Rendering
      CONTENT_TYPES = {
        'text' => 'text/plain',
        'html' => 'text/html'
      }

      TEMPLATE_PROCESSORS = {
        'erb' => -> template, bind { ERB.new(template).result(bind) }
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
          _, content_type, *exts = full_temp_name.split('.')
          content_type ||= 'text'

          self._body = exts.reverse.reduce(temp) do |current_temp, engine_name|
            TEMPLATE_PROCESSORS[engine_name].call(current_temp, binding)
          end

          self._headers['Content-Type'] = CONTENT_TYPES[content_type]
        end
      end
    end
  end
end
