require 'furry'

class DemoApp < Furry::App
  class InfoController < Controller
    def index
      redirect_to about_path
    end

    def about
      render template: 'info/about'
    end

    def health
      render text: 'OK'
    end

    def random_number
      @number = rand(0..params[:number].to_i)
      render template: 'info/random_number'
    end

    def random_100
      redirect_to random_path(100)
    end
  end

  TEMPLATES['info/about.html.erb'] = "Running Furry Web Framework v<%= Furry::VERSION %> on Ruby <%= RUBY_VERSION %>. <%= params[:thing] %>"
  TEMPLATES['info/random_number.html.erb'] = "rand(0..<%= params[:number] %>) # => <%= @number %>"

  router.draw do
    get '/', 'info#index'
    get '/about', 'info#about', name: 'about'
    get '/health', 'info#health'
    get '/random', 'info#random_100'
    get '/random/:number', 'info#random_number', name: 'random'
  end
end
