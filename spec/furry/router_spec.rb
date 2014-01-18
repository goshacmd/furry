require 'spec_helper'

describe Furry::Router do
  subject(:router) { described_class.new }

  describe '#map' do
    it 'adds the route->handler mapping' do
      route = double
      expect(Furry::Route).to receive(:new).with(:GET, '/', 'info#index').and_return route
      expect { router.map(:GET, '/', 'info#index') }.to \
        change { router.mappings[:GET] }.by([route])
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
