module Furry
  module UrlHelpers
    # Try to get named route helpers for methods named +xxx_path+.
    def method_missing(name, *args)
      name_s = name.to_s

      if router && name_s.end_with?('_path') && route = router.names[name_s.gsub('_path', '')]
        route.generate_url(args)
      else
        super
      end
    end
  end
end
