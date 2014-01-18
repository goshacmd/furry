require 'spec_helper'

describe Furry::Route do
  subject(:route) { described_class.new(:GET, '/posts/:post_id', 'posts#show') }

  describe '#initialize' do
    it 'extracts segments from path and creates path regexp' do
      route = described_class.new :GET, '/posts/:post_id/attachments/:attach_id', 'attachments#show'

      expect(route.segments).to eq %w{post_id attach_id}
      expect(route.regexp).to eq %r{/posts/(?<post_id>\w+)/attachments/(?<attach_id>\w+)/?$}
    end
  end

  describe '#matches?' do
    it 'checks whether passed path matches the route' do
      expect(route.matches?('/posts/1')).to be_true
      expect(route.matches?('/posts/')).to be_false
    end
  end

  describe '#match' do
    it 'returns matched segments and handler' do
      expect(route.match('/posts/1')).to eq ['posts#show', { 'post_id' => '1' }]
    end
  end
end
