require 'spec_helper'

describe Furry::UrlHelpers do
  let(:controller_class) { Class.new { include Furry::UrlHelpers } }
  subject(:controller) { controller_class.new }

  let(:route1) { double('route1') }
  let(:router) { double('router', names: { 'demo1' => route1 }) }

  before do
    controller.stub(router: router)
  end

  describe 'path methods' do
    context 'when getting known route path' do
      it 'generates path' do
        expect(route1).to receive(:generate_url).with([1, 2, 3])
        controller.demo1_path(1, 2, 3)
      end
    end

    context 'when getting unknown route path' do
      it 'raises NameError' do
        expect { controller.lol_path }.to raise_error(NameError)
      end
    end
  end
end
