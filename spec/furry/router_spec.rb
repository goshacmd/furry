require 'spec_helper'

describe Furry::Router do
  subject(:router) { described_class.new }

  describe '#map' do
    it 'adds the route->handler mapping' do
      handler = double

      expect { router.map(:GET, '/', handler) }.to \
        change { router.match(:GET, '/') }.to(handler)
    end
  end

  describe '#match' do
    let(:get_handler) { double }
    let(:post_handler) { double }

    before do
      router.map(:GET, '/', get_handler)
      router.map(:POST, '/', post_handler)
    end

    it 'finds matching route handler' do
      expect(router.match(:POST, '/')).to eq post_handler
    end
  end
end
