# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path('../../lib/countries/mongoid', __FILE__)

describe 'Mongoid support' do

  let(:britain) { ISO3166::Country.new('GB') }
  context 'instance methods' do
    describe 'mongoize' do
      it 'should delegate mongoization to the class method' do
        britain.mongoize.should eql ISO3166::Country.mongoize(britain)
      end
    end
  end

  context 'class methods' do
    describe 'mongoize' do
      it 'should store the alpha2 given a country object' do
        ISO3166::Country.mongoize(britain).should eql britain.alpha2
      end

      it 'should store the alpha2 given a valid alpha2' do
        ISO3166::Country.mongoize('GB').should eql britain.alpha2
      end

      it 'should raise BadMongoidTypeError given an invalid object' do
        bad_types = [[], Time.now, {}, Date.today]
        bad_types.each do |type|
          expect { ISO3166::Country.mongoize(type) }
          .to raise_error(ISO3166::Country::BadMongoidTypeError, /neither/)
        end
      end

      it 'should raise BadMongoidTypeError given an empty country object' do
        expect { ISO3166::Country.mongoize(ISO3166::Country.new('')) }
        .to raise_error(ISO3166::Country::BadMongoidTypeError, /neither/)
      end

      it 'should raise BadMongoidTypeError given a bad alpha2' do
        expect { ISO3166::Country.mongoize('bad_alpha_2') }
        .to raise_error(ISO3166::Country::BadMongoidTypeError,
                        /not a valid alpha2/)
      end

    end

    describe 'demongoize' do
      it 'should instantiate an equivalent object from stored alpha2 code' do
        ISO3166::Country.demongoize(britain.mongoize).data
          .should eql britain.data
      end

      it 'should be indifferent to storage by alpha2' do
        ISO3166::Country.demongoize(ISO3166::Country.mongoize('GB'))
        .data.should eql britain.data
      end
    end

    describe 'evolve' do
      it 'should delegate to self.mongoize and return the mongoized object' do
        ISO3166::Country.should_receive(:mongoize).with(britain)
        ISO3166::Country.evolve(britain)
      end
    end
  end
end
