require 'rack'
require 'furry'

class DemoApp < Furry::App
  map :GET, '/about' do
    [200, {}, ["Running Furry Web Framework v#{Furry::VERSION} on Ruby #{RUBY_VERSION}"]]
  end

  map :GET, '/health' do
    [200, {}, ['OK']]
  end
end

Rack::Handler::WEBrick.run DemoApp.new, Port: 8888
