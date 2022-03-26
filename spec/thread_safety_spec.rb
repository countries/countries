# frozen_string_literal: true

describe 'Accessing ISO3166::Country instances data in multiple threads' do
  before do
    if Thread.respond_to?(:report_on_exception)
      @report_on_exception_value = Thread.report_on_exception
      Thread.report_on_exception = false
    end

    ISO3166::Data.reset
  end

  def create_countries_threaded
    nthreads = 100
    threads = []

    alpha2_codes = %w[us es nl ca de fr mx ru ch jp]

    nthreads.times do
      threads << Thread.new do
        alpha2_codes.each do |a2|
          country = ISO3166::Country[a2]
          # This will fail if data['translations'] has been
          # left nil due to a race condition
          country.translation
        end
      end
    end
    threads.map(&:join)
  end

  it "doesn't raise any exceptions when using a mutex" do
    expect { create_countries_threaded }.to_not raise_error
  end

  it 'raises NoMethodError when not using a mutex' do
    allow(ISO3166::Data).to receive(:use_mutex?).and_return(false)

    expect { create_countries_threaded }.to raise_error(NoMethodError)
  end

  after do
    if Thread.respond_to?(:report_on_exception)
      Thread.report_on_exception = @report_on_exception_value
    end
  end
end
