# Furry

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
  end

  router.get '/', 'home#index'
end
```

## License

[MIT](LICENSE).
