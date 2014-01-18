require 'rack'
require 'furry'

class DemoApp < Furry::App
  class InfoController < Controller
    def about
      render erb: "Running Furry Web Framework v<%= Furry::VERSION %> on Ruby <%= RUBY_VERSION %>. <%= params[:thing] %>"
    end

    def health
      render text: 'OK'
    end

    def number
      render erb: "The number was <%= params[:number] %>"
    end
  end

  router.draw do
    get '/about', 'info#about'
    get '/health', 'info#health'
    get '/numbers/:number', 'info#number'
  end
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
