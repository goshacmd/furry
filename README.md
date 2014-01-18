# Furry

[![Build Status](https://travis-ci.org/goshakkk/furry.png?branch=master)](https://travis-ci.org/goshakkk/furry)
[![Code Climate](https://codeclimate.com/github/goshakkk/furry.png)](https://codeclimate.com/github/goshakkk/furry)

Simplisitc web framework.

## Installation

Add this line to your application's Gemfile:

    gem 'furry'

Or install it yourself as:

    $ gem install furry

## Usage

```ruby
class DemoApp < Furry::App
  class HomeController < Controller
    def index
      render 'Ta-da'
    end

    def random_number
      number = rand(0..params[:max].to_i)
      render "The number is #{number}"
    end
  end

  router.get '/', 'home#index'
  router.get '/random/:max', 'home#random_number'
end
```

```bash
$ curl localhost:8888
Ta-da
$ curl localhost:8888/random/100
The number is 42
```

## License

[MIT](LICENSE).
