require 'rack'
require 'furry'

class DemoApp < Furry::App
  class InfoController < Controller
    def about
      render "Running Furry Web Framework v#{Furry::VERSION} on Ruby #{RUBY_VERSION}"
    end

    def health
      render 'OK'
    end
  end

  router.map :GET, '/about', 'info#about'
  router.map :GET, '/health', 'info#health'
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
