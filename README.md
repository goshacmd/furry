# Furry

[![Build Status](https://travis-ci.org/goshakkk/furry.png?branch=master)](https://travis-ci.org/goshakkk/furry)
[![Code Climate](https://codeclimate.com/github/goshakkk/furry.png)](https://codeclimate.com/github/goshakkk/furry)

Simplistic web framework.

## Installation

Add this line to your application's Gemfile:

    gem 'furry'

Or install it yourself as:

    $ gem install furry

## Usage

```ruby
require 'furry'

class DemoApp < Furry::App
  class HomeController < Controller
    def index
      render text: 'Ta-da'
    end

    def random_number
      @number = rand(0..params[:max].to_i)
      render erb: "The number is <%= @number %>"
    end

    def random_100
      redirect_to random_path(100)
    end
  end

  router.draw do
    get '/', 'home#index'
    get '/random', 'home#random_100'
    get '/random/:max', 'home#random_number', name: 'random'
  end
end
```

```bash
$ curl localhost:8888
Ta-da
$ curl -L localhost:8888/random
The number is 42
$ curl localhost:8888/random/500
The number is 261
```

## License

[MIT](LICENSE).
