require 'spec_helper'

describe Furry::Router do
  subject(:router) { described_class.new }

  describe '#map' do
    it 'adds the route->handler mapping' do
      handler = 'info#index'
      path = '/'
      path_re = %r{/$}

      expect { router.map(:GET, path, handler) }.to \
        change { router.mappings[[:GET, path_re]] }.to [[], handler]

      path = '/:number'
      path_re = %r{/(\w+)$}

      expect { router.map(:GET, path, handler) }.to \
        change { puts router.inspect; router.mappings[[:GET, path_re]] }.to [['number'], handler]
    end
  end

  describe '#match' do
    let(:get_handler) { 'home#index' }
    let(:post_handler) { 'posts#update' }

    before do
      router.map(:GET, '/', get_handler)
      router.map(:POST, '/posts/:id', post_handler)
    end

    it 'finds matching route handler' do
      expect(router.match(:GET, '/')).to eq [get_handler, {}]
      expect(router.match(:POST, '/posts/10')).to eq [post_handler, {'id' => '10'}]
    end
  end
end
