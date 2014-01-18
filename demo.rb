require 'rack'
require 'furry'

app = Furry::App.new

app.map :GET, '/about' do
  [200, {}, ["Running Furry Web Framework v#{Furry::VERSION} on Ruby #{RUBY_VERSION}"]]
end

app.map :GET, '/health' do
  [200, {}, ['OK']]
end

Rack::Handler::WEBrick.run app, Port: 8888
