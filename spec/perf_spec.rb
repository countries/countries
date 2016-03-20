# encoding: utf-8
require 'spec_helper'

describe ISO3166::Data, perf: true, order: :defined do
  ALL_LOCALES = [
    :af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de,
    :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he,
    :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku,
    :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or,
    :pa, :pl, :ps, :pt, :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw,
    :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh,
    :zh, :zu].freeze

  it 'responds to call' do
    require 'benchmark'
    require 'memory_profiler'
    require 'ruby-prof'
    # profile the code
    RubyProf.start

    data = ISO3166::Data.new('US').call
    expect(data['translated_names']).to be_a Array

    result = RubyProf.stop

    # print a flat profile to text
    printer = RubyProf::GraphPrinter.new(result)
    printer.print(STDOUT, min_percent: 2)
  end

  it 'locales will load prior to return results' do
    ISO3166.configuration.locales = [:es, :de, :en]
    report = MemoryProfiler.report do
      ISO3166::Data.update_cache
    end

    report.pretty_print(to_file: 'tmp/memory/3_locales')
    puts Benchmark.measure { ISO3166::Data.update_cache }

    ISO3166.configure do |config|
      config.locales = ALL_LOCALES
    end
    puts Benchmark.measure { ISO3166::Data.update_cache }

    report = MemoryProfiler.report do
      ISO3166::Data.update_cache
    end

    report.pretty_print(to_file: 'tmp/memory/all_locales')
  end
end
