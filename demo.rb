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

  router.get '/about', 'info#about'
  router.get '/health', 'info#health'
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
