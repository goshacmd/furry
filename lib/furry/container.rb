module Furry
  module Container
    def lookup(name, kind)
      const_get("#{name}_#{kind}".camelize)
    end

    def lookup_controller(name)
      lookup(name, :controller)
    end
  end
end
