module Furry
  class Route
    attr_reader :method, :path, :regexp, :segments, :handler

    # Intialize a new +Route+.
    #
    # @param method [Symbol]
    # @param path [String]
    # @param handler [String]
    def initialize(method, path, handler)
      @method = method.to_sym
      @path = path
      @handler = handler

      @segments = []
      # replace things like ":id" with "(?<id>\w+)"
      @regexp = Regexp.new(path.gsub(/:\w+/) { |m| m = m[1..-1]; @segments << m; "(?<#{m}>\\w+)" } + '/?$')
    end

    # Check if the route matches passed path.
    #
    # @param request_path [String]
    def matches?(request_path)
      !!regexp.match(request_path)
    end

    # Match request path.
    #
    # @param request_path [String]
    # @return [Array] +(handler,params)+ pair
    def match(request_path)
      _, *segment_values = regexp.match(request_path).to_a
      params = segments.zip(segment_values).to_h

      [handler, params]
    end

    # Generate URL for parameters.
    #
    # @param segment_values [Array] segment values
    # @raise ArgumentError if wrong number of segment values is passed
    # @return [String]
    def generate_url(segment_values = [])
      unless segments.count == segment_values.count
        raise ArgumentError, "expected #{segments.count} segment values, got #{segment_values.count}"
      end

      params = segments.zip(segment_values).to_h

      path.gsub(/:\w+/) { |m| m = m[1..-1]; params[m] }
    end

    def inspect
      "#<#{self.class.name} #{method} #{path} => #{handler}>"
    end
  end
end
