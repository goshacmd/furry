module Furry
  class Template
    ENGINES = {
      'erb' => -> template, bind { ERB.new(template).result(bind) }
    }

    class << self
      def components_for_name(name)
        _, type, *engines = name.split('.')
        [type, engines]
      end

      # Get a list of engines to process the template with name of
      # +name+.
      #
      # @param name [String] template name
      # @return [Array<String>]
      def engines_for_name(name)
        components_for_name(name).last
      end
    end

    attr_reader :name, :template

    def initialize(name, template)
      @name = name
      @template = template
    end

    def render_template(context)
      engines.reverse.reduce(template) do |current, engine|
        ENGINES[engine].call(current, context)
      end
    end

    def render(context)
      type, _ = self.class.components_for_name(name)
      [type, render_template(context)]
    end

    def engines
      self.class.engines_for_name(name)
    end
  end
end
