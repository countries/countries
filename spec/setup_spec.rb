# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ISO3166::Setup do
  it 'responds to codes' do
    setup = ISO3166::Setup.new
    expect(setup.codes).to be_a Array
  end

  it 'responds to data' do
    setup = ISO3166::Setup.new
    expect(setup.data).to be_a Hash
  end
end
