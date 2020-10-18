# encoding: utf-8

require 'spec_helper'

describe ISO3166::Country do
  it 'should return a subdivision/region name if defined' do
    test_subdivision_name %i[at br de mm mx my ng pw sd ss ve us], 'State'
    test_subdivision_name %i[au in], 'State/Territory'
    test_subdivision_name %i[be by cl dk et om pe fr kg], 'Region'
    test_subdivision_name %i[ca], 'Territory/Province'
    # TW should be tested in the following block, but a hotloading test has overwritten the country
    test_subdivision_name %i[ao ar bf bg cn cr do dz ec ga id ir ke nl pa za], 'Province'
    test_subdivision_name %i[mn], 'Province/Municipality'
    test_subdivision_name %i[cf jp td gr], 'Prefecture'
    test_subdivision_name %i[eg iq kw lb sy tn ye], 'Governorate'
    test_subdivision_name %i[bj bo ci co gt hn ht py sv], 'Department'
    test_subdivision_name %i[ee hr hu no se ro ie], 'County'
    test_subdivision_name %i[ch ba], 'Canton'
    test_subdivision_name %i[ad ag bb dm gd je kn ms vc], 'Parish'
    test_subdivision_name %i[bz lu af bd], 'District'
    test_subdivision_name %i[lv ly rs si], 'Municipality'
  end

  it 'should return null if no subdivision/region name is defined' do
    country = described_class.new(:ae)
    expect(country.subdivision_name).to be_nil
  end
end

def test_subdivision_name(codes, word)
  codes.each do |code|
    country = ISO3166::Country.new(code)
    # Output just to find outliers
    puts "Failed country code: #{code}" if country.subdivision_name != word
    expect(country.subdivision_name).to eql(word)
  end
end
