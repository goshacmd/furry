require 'rack'
require 'furry'

class DemoApp < Furry::App
  class InfoController < Controller
    def about
      render "Running Furry Web Framework v#{Furry::VERSION} on Ruby #{RUBY_VERSION}. #{params[:thing]}"
    end

    def health
      render 'OK'
    end

    def number
      render "The number was #{params[:number]}"
    end
  end

  router.get '/about', 'info#about'
  router.get '/health', 'info#health'
  router.get '/numbers/:number', 'info#number'
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
