# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ISO3166::Setup do
  let(:setup) { ISO3166::Setup.new }

  it 'responds to data' do
    expect(setup.data).to be_a Hash
  end
end
