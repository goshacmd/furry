module Furry
  class Router
    attr_reader :mappings

    # Initialize a new +Router+.
    def initialize
      @mappings = {}
    end

    # Map a handler to (method,path) pair. Pass either a proc or a
    # block.
    #
    # @param method [Symbol] request method (+:GET+, +:POST+, etc)
    # @param path [String]
    # @param handler [String] controller & action (e.g. +'info#about'+)
    def map(method, path, handler)
      segments = []
      # replace things like ":id" with "(?<id>\w+)"
      path = Regexp.new(path.gsub(/:\w+/) { |m| m = m[1..-1]; segments << m; "(?<#{m}>\\w+)" } + '$')
      @mappings[[method, path]] = [segments, handler]
    end

    def get(path, handler)
      map(:GET, path, handler)
    end

    def post(path, handler)
      map(:POST, path, handler)
    end

    # Find a route handler.
    #
    # @param method [Symbol] request method
    # @param path [String]
    #
    # @return [Array] array of +(handler,params)+
    def match(method, path)
      all = @mappings.select { |(meth, path), _| method == meth }

      (_, regexp), (segments, handler) = all.find do |(_, reg), _|
        reg.match(path)
      end

      _, *segment_values = regexp.match(path).to_a
      params = segments.zip(segment_values).to_h

      [handler, params]
    end
  end
end
