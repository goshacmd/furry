require 'spec_helper'

describe Furry::Controller do
  let(:controller_class) do
    Class.new(described_class) do
      def index; render text: 'Index' end
    end
  end

  let(:app) { double('app') }

  subject(:controller) { controller_class.new(app) }

  describe '#execute_action' do
    it 'executes action' do
      expect(controller).to receive(:index)
      controller.execute_action(:index)
    end

    it 'returns rendered content' do
      expect(controller.execute_action(:index)).to eq [200, {'Content-Type' => 'text/plain'}, ['Index']]
    end
  end

  describe '.action_methods' do
    it 'returns names of methods defined on controller subclass' do
      expect(controller_class.action_methods).to eq [:index]
    end
  end
end
