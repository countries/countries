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
    expect(data['translated_names'].size).to eq (3)
  end

  it 'can load selective locales and reload efficiently' do
    ISO3166.configuration.locales = [:es, :de, :en]
    data = ISO3166::Data.new('US').call
    expect(data['translations']).to eq({"de"=>"Vereinigte Staaten", "es"=>"Estados Unidos", "en"=>"United States"})
    expect(data['translated_names'].sort).to eq ["Vereinigte Staaten", "Estados Unidos", "United States"].sort
    ISO3166.configuration.locales = [:en]
    data = ISO3166::Data.new('US').call
    expect(data['translated_names'].size).to eq (1)
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
    expect(ISO3166::Data.locales_to_load ).to eql(['es', 'de', 'en'])
    ISO3166::Data.update_cache
    ISO3166.configuration.locales = [:es, :de, :en]
    expect(ISO3166::Data.locales_to_load ).to eql([])
  end

  it 'locales will load prior and be cached' do
    ISO3166.reset
    ISO3166.configuration.locales = [:es, :de, :en]
    expect(ISO3166::Data.locales_to_remove ).to eql([])
    expect(ISO3166::Country.new('DE').translation('de')).to eq 'Deutschland'
    ISO3166::Data.update_cache
    ISO3166.configuration.locales = [:es, :en]
    expect(ISO3166::Data.locales_to_remove ).to eql(['de'])
    expect(ISO3166::Country.new('DE').translation('de')).to eq nil
  end
end
