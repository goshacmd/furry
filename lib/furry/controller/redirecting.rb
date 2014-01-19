module Furry
  class Controller
    module Redirecting
      # Redirect the browser to +location+.
      #
      # @param location [String]
      # @param status [Integer] status code
      def redirect_to(location, status: 302)
        self._status = status
        self._headers['Location'] = location
        self._body = ''
      end
    end
  end
end
