require 'rack'
require 'furry'

class DemoApp < Furry::App
  class InfoController < Controller
    def index
      redirect_to about_path
    end

    def about
      render erb: "Running Furry Web Framework v<%= Furry::VERSION %> on Ruby <%= RUBY_VERSION %>. <%= params[:thing] %>"
    end

    def health
      render text: 'OK'
    end

    def number
      render erb: "The number was <%= params[:number] %>"
    end

    def random_number
      @number = rand(0..params[:number].to_i)
      render erb: "rand(0..#{params[:number]}) # => #{@number}"
    end

    def random_100
      redirect_to random_path(100)
    end
  end

  router.draw do
    get '/', 'info#index'
    get '/about', 'info#about', name: 'about'
    get '/health', 'info#health'
    get '/numbers/:number', 'info#number'
    get '/random', 'info#random_100'
    get '/random/:number', 'info#random_number', name: 'random'
  end
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
