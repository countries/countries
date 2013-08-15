# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path('../../lib/countries/mongoid', __FILE__)

describe 'Mongoid support' do

  let(:britain) { ISO3166::Country.new('GB') }
  let(:netherlands) { ISO3166::Country.new('NL') }

  context 'instance methods' do

    describe 'mongoize' do

      it 'should delegate mongoization to the class method' do
        britain.mongoize.should eql ISO3166::Country.mongoize(britain)
      end

    end

  end

  context 'class methods' do

    describe 'mongoize' do

      it 'should store the alpha2 code in the database' do
        ISO3166::Country.mongoize(britain).should eql britain.alpha2
      end

    end

    describe 'demongoize' do

      it 'should instantiate an equivalent object from the stored alpha2 code' do
        ISO3166::Country.demongoize(netherlands.mongoize).data.should eql netherlands.data
      end

    end

    describe 'evolve' do

      it 'should return the mongoized object' do
        ISO3166::Country.evolve(britain)
          .should eql ISO3166::Country.mongoize(britain)
      end

    end

  end
end
