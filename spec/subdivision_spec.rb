# coding: utf-8

require 'spec_helper'

describe ISO3166::Subdivision do
  let(:countries) { ISO3166::Country.all }
  let(:available_types) { [Hash, NilClass] }

  describe 'translations' do
    it 'should be hash or nil' do
      countries.each do |country|
        country.subdivisions.each do |_, region|
          expect(available_types).to include(region.translations.class)
        end
      end
    end
  end
end
