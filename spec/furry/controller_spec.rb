require 'spec_helper'

describe Furry::Controller do
  subject(:controller) { described_class.new }

  describe '#render' do
    it 'returns rack response for supplied text and status code' do
      expect(controller.render('ABC')).to eq [200, {}, ['ABC']]
      expect(controller.render('DEF', status: 201)).to eq [201, {}, ['DEF']]
    end
  end
end
