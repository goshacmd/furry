require 'spec_helper'

describe Furry::Controller do
  let(:controller_class) do
    Class.new(described_class) do
      def index; render 'Index' end
      def index2; [200, {}, ['Index 2']] end
    end
  end

  subject(:controller) { controller_class.new }

  describe '#execute_action' do
    it 'executes action' do
      expect(controller).to receive(:index)
      controller.execute_action(:index)
    end

    it 'returns rendered content' do
      expect(controller.execute_action(:index)).to eq [200, {}, ['Index']]
    end

    it 'returns action return value if nothing was rendered' do
      expect(controller.execute_action(:index2)).to eq [200, {}, ['Index 2']]
    end
  end
end
