require 'spec_helper'

describe Furry::App do
  subject(:app) { described_class.new }

  describe '#call' do
    let(:router) { double('router', match: nil) }

    before do
      app.stub(router: router)
    end

    it 'finds the route handler' do
      expect(router).to receive(:match).with(:GET, '/')
      call(app, :GET, '/')
    end

    it 'calls the route handler' do
      handler = double
      router.stub(match: handler)
      expect(handler).to receive(:call)
      call(app, :GET, '/')
    end

    it 'returns four-oh-four if no handler is found' do
      expect(call(app, :GET, '/404')).to eq [404, {}, ['Route not found']]
    end
  end

  def call(app, method, path)
    app.call('REQUEST_METHOD' => method.to_s, 'REQUEST_PATH' => path)
  end
end
