# frozen_string_literal: true

require 'spec_helper'
require 'i18n'

describe 'ISO3166.configuration' do
  it 'has a configuration' do
    expect(ISO3166.configuration).to be_a ISO3166::Configuration
  end

  it 'locales can be changed' do
    ISO3166.configuration.locales = [:es]
    ISO3166.configuration.locales << :de
    expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
    expect(ISO3166::Country.new('DE').translation(:es)).to eq 'Alemania'
    expect(ISO3166::Country.new('DE').translation(:en)).to eq nil
  end

  it 'locales are assumed from I18n.available_locales' do
    I18n.available_locales = %i[de en]
    ISO3166.reset
    expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
    expect(ISO3166::Country.new('DE').translation(:es)).to eq nil
  end

  it 'unsupported locales do not affect supported locales' do
    I18n.available_locales = %i[de en unsupported]
    ISO3166.reset
    expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
    expect(ISO3166::Country.new('DE').translation(:es)).to eq nil
  end

  it 'locales can be changed' do
    ISO3166.configuration.locales = [:de]
    expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
    expect(ISO3166::Country.new('DE').translation(:es)).to eq nil
  end

  it 'locales can be changed' do
    ISO3166.configuration.locales = %i[es de en]
    expect(ISO3166::Country.new('DE').translation(:es)).to eq 'Alemania'
    expect(ISO3166::Country.new('DE').translation(:en)).to eq 'Germany'
    expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
  end

  it 'locales can be changed with a block' do
    ISO3166.configure do |config|
      config.locales = %i[af am ar as az be bg bn br bs ca cs cy da de dz el en
                          eo es et eu fa fi fo fr ga gl gu he hi hr hu hy ia id
                          is it ja ka kk km kn ko ku lt lv mi mk ml mn mr ms mt
                          nb ne nl nn oc or pa pl ps pt ro ru rw si sk sl so sq
                          sr sv sw ta te th ti tk tl tr tt ug uk ve vi wa wo xh
                          zh zu]
    end

    expect(ISO3166::Country.new('DE').translations.size).to eq 92

    expect(ISO3166.configuration.loaded_locales.size).to eq 92
  end

  context 'lazy load default locales' do
    it 'does not load default locales during initialization' do
      expect(I18n).to receive(:available_locales).never

      ISO3166::Configuration.new
    end

    it 'loads default locales when calling #locales for the first time' do
      expect(I18n).to receive(:available_locales).once.and_return([:test])

      expect(ISO3166::Configuration.new.locales).to eq([:test])
    end
  end

  context 'locales can be set with strings' do
    it 'allows setting locales with strings' do
      ISO3166.configuration.locales = ['de', 'en']
      expect(ISO3166::Country.new('DE').translation(:de)).to eq 'Deutschland'
      expect(ISO3166::Country.new('DE').translation(:en)).to eq 'Germany'
    end

    it 'converts string locales to symbols' do
      ISO3166.configuration.locales = ['de', 'en']
      expect(ISO3166.configuration.locales).to eq [:de, :en]
    end
  end
end
