require 'spec_helper'

describe Furry::App do
  subject(:app) { described_class.new }

  describe '#call_action' do
    let(:controller) do
      Class.new(Furry::Controller) do
        def about; render text: params['version'] end
      end
    end

    let(:handler) { 'info#about' }

    before do
      app.stub(lookup_controller: controller)
    end

    it 'instantiates controller and calls action' do
      expect(app.call_action(handler, {'version'=>'1.0.0'}, {})).to eq [200, {}, ['1.0.0']]
    end
  end

  describe '#call' do
    let(:router) { double('router', match: nil) }

    before do
      app.stub(router: router)
    end

    it 'finds the route handler' do
      expect(router).to receive(:match).with(:GET, '/')
      call(app, :GET, '/')
    end

    it 'calls controller action' do
      router.stub(match: 'info#about')
      expect(app).to receive(:call_action).with('info#about', {}).and_return([200, {}, ['O']])
      expect(call(app, :GET, '/')).to eq [200, {}, ['O']]
    end

    it 'returns four-oh-four if no handler is found' do
      expect(call(app, :GET, '/404')).to eq [404, {}, ['Route not found']]
    end
  end

  def call(app, method, path)
    app.call('REQUEST_METHOD' => method.to_s, 'REQUEST_PATH' => path, 'QUERY_STRING' => '')
  end
end
