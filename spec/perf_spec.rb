# frozen_string_literal: true

require 'spec_helper'

ALL_LOCALES = %i[
  af am ar as az be bg bn br bs ca cs cy da de
  dz el en eo es et eu fa fi fo fr ga gl gu he
  hi hr hu hy ia id is it ja ka kk km kn ko ku
  lt lv mi mk ml mn mr ms mt nb ne nl nn oc or
  pa pl ps pt ro ru rw si sk sl so sq sr sv sw
  ta te th ti tk tl tr tt ug uk ve vi wa wo xh
  zh zu
].freeze

describe ISO3166::Data, perf: true, order: :defined do
  def perf_report(_name)
    require 'benchmark'
    require 'memory_profiler'
    require 'ruby-prof'
    # profile the code
    RubyProf.start

    100.times do
      yield if block_given?
    end

    result = RubyProf.stop

    # print a flat profile to text
    printer = RubyProf::FlatPrinter.new(result)
    printer.print($stdout)
  end

  it 'responds to call' do
    perf_report('translations') do
      ISO3166.reset
      data = ISO3166::Data.new('US').call
      expect(data['translated_names']).to be_a Array
    end
  end

  it 'locales will load prior to return results' do
    ISO3166.configuration.locales = %i[es de en]
    report = MemoryProfiler.report do
      ISO3166::Data.update_cache
    end

    report.pretty_print(to_file: 'tmp/3_locales.txt')
    puts Benchmark.measure { ISO3166::Data.update_cache }

    ISO3166.configure do |config|
      config.locales = ALL_LOCALES
    end
    puts Benchmark.measure { ISO3166::Data.update_cache }

    report = MemoryProfiler.report do
      ISO3166::Data.update_cache
    end

    report.pretty_print(to_file: 'tmp/all_locales.txt')
  end

  it 'loades a specfic country quickly' do
    codes = Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq
    Benchmark.bmbm do |bm|
      bm.report('find_by_alpha2') do
        codes.map { |cc| ISO3166::Country.find_country_by_alpha2 cc }
      end
      bm.report('new') do
        codes.map { |cc| ISO3166::Country.new cc }
      end
    end
  end
end
