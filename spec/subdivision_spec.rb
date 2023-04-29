# frozen_string_literal: true

require 'spec_helper'

describe ISO3166::Subdivision do
  before do
    ISO3166::Data.reset
  end

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

  describe 'state codes' do
    it 'should all be strings' do
      countries.each do |country|
        expect(country.subdivisions.keys).to(
          all(be_a(String)),
          "Expected #{country.alpha2.inspect} to have string subdivision \
           codes but had #{country.subdivisions.keys.inspect}"
        )
      end
    end
  end

  describe 'code_with_translations' do
    before { ISO3166.configuration.locales = %i[en pt] }
    it 'returns a hash' do
      expect(ISO3166::Country.new('IT').subdivisions['NA'].code_with_translations).to eq({ 'NA' => { 'en' => 'Naples',
                                                                                                     'pt' => 'Nápoles' } })
    end
  end
end
