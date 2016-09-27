# encoding: utf-8
require 'spec_helper'
require 'benchmark'

describe ISO3166::Data do
  it 'responds to call' do
    data = ISO3166::Data.new('US').call
    expect(data['translated_names']).to be_a Array
  end

  it 'can load selective locales' do
    # ISO3166::Data.update_cache
    ISO3166.configuration.locales = [:es, :de, :en]
    data = ISO3166::Data.new('US').call
    expect(data['translated_names'].size).to eq 3
  end

  it 'can load selective locales and reload efficiently' do
    ISO3166.configuration.locales = [:es, :de, :en]
    data = ISO3166::Data.new('US').call
    expect(data['translations']).to eq('de' => 'Vereinigte Staaten', 'es' => 'Estados Unidos', 'en' => 'United States')
    expect(data['translated_names'].sort).to eq ['Vereinigte Staaten', 'Estados Unidos', 'United States'].sort
    ISO3166.configuration.locales = [:en]
    data = ISO3166::Data.new('US').call
    expect(data['translated_names'].size).to eq 1
  end

  describe '#codes' do
    it 'returns an array' do
      data = ISO3166::Data.codes
      expect(data).to be_a Array
      expect(data.size).to eq 249
    end
  end

  it 'locales will load prior to return results' do
    # require 'memory_profiler'
    ISO3166.configuration.locales = [:es, :de, :en]
    # report = MemoryProfiler.report do
    ISO3166::Data.update_cache
    # end

    # report.pretty_print(to_file: 'tmp/memory/3_locales')
    ISO3166::Data.update_cache

    ISO3166.configure do |config|
      config.locales = [:af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de, :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he, :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku, :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or, :pa, :pl, :ps, :pt, :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw, :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh, :zh, :zu]
    end
    # puts Benchmark.measure {ISO3166::Data.update_cache}

    # report = MemoryProfiler.report do
    ISO3166::Data.update_cache
    # end

    # report.pretty_print(to_file: 'tmp/memory/all_locales')

    expect(ISO3166::Country.new('DE').translations.size).to eq 92

    expect(ISO3166.configuration.loaded_locales.size).to eq 92
  end

  it 'locales will load prior and be cached' do
    ISO3166.reset
    ISO3166.configuration.locales = [:es, :de, :en]
    expect(ISO3166::Data.send(:locales_to_load)).to eql(%w(es de en))
    ISO3166::Data.update_cache
    ISO3166.configuration.locales = [:es, :de, :en]
    expect(ISO3166::Data.send(:locales_to_load)).to eql([])
  end

  it 'locales will load prior and be cached' do
    ISO3166.reset
    ISO3166.configuration.locales = [:es, :de, :en]
    expect(ISO3166::Data.send(:locales_to_remove)).to eql([])
    expect(ISO3166::Country.new('DE').translation('de')).to eq 'Deutschland'
    ISO3166::Data.update_cache
    ISO3166.configuration.locales = [:es, :en]
    expect(ISO3166::Data.send(:locales_to_remove)).to eql(['de'])
    expect(ISO3166::Country.new('DE').translation('de')).to eq nil
  end

  describe '#load_cache' do
    it 'will return an empty hash for an unsupported locale' do
      file_array = %w(cache locales unsupported.json)
      expect(ISO3166::Data.send(:load_cache, file_array)).to eql({})
    end

    it 'will return json for a supported locale' do
      file_array = %w(cache locales en.json)
      expect(ISO3166::Data.send(:load_cache, file_array)).not_to be_empty
    end
  end

  describe 'hotloading existing data' do
    before do
      ISO3166::Data.register(
        alpha2: 'TW',
        name: 'NEW Taiwan',
        translations: {
          'en' => 'NEW Taiwan',
          'de' => 'NEW Taiwan'
        }
      )
    end

    subject { ISO3166::Country.new('TW') }

    it 'can be done' do
      data = ISO3166::Data.new('TW').call
      ISO3166.configuration.locales = [:es, :de, :de]
      expect(data['name']).to eq 'NEW Taiwan'
      expect(subject.name).to eq 'NEW Taiwan'
      expect(subject.translations).to eq('en' => 'NEW Taiwan',
                                         'de' => 'NEW Taiwan')
    end
  end

  describe 'hotloading data' do
    before do
      ISO3166::Data.register(
        alpha2: 'LOL',
        name: 'Happy Country',
        translations: {
          'en' => 'Happy Country',
          'de' => 'glückliches Land'
        }
      )
    end

    subject { ISO3166::Country.new('LOL') }

    it 'can be done' do
      data = ISO3166::Data.new('LOL').call
      expect(data['name']).to eq 'Happy Country'
      expect(subject.name).to eq 'Happy Country'
    end

    it 'detect a stale cache' do
      ISO3166::Data.register(alpha2: 'SAD', name: 'Sad Country')
      data = ISO3166::Data.new('SAD').call
      expect(data['name']).to eq 'Sad Country'
      expect(ISO3166::Country.new('SAD').name).to eq 'Sad Country'
      ISO3166::Data.unregister('SAD')
    end

    it 'will not override custom translations' do
      data = ISO3166::Data.new('LOL').call
      expect(data['translations']).to eq('en' => 'Happy Country',
                                         'de' => 'glückliches Land')
      expect(subject.translations).to eq('en' => 'Happy Country',
                                         'de' => 'glückliches Land')
    end

    it 'leaves remain countries intact after a hotload' do
      data = ISO3166::Data.new('US').call
      expect(data).to include('subregion')
    end

    it 'can be undone' do
      ISO3166::Data.unregister('lol')
      data = ISO3166::Data.new('LOL').call
      expect(data).to eq nil
    end

    after do
      ISO3166::Data.unregister('lol')
    end
  end
end
