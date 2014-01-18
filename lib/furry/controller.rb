module Furry
  class Controller
    def render(text, status: 200)
      [status, {}, [text]]
    end
  end
end
