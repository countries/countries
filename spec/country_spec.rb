# frozen_string_literal: true

require 'spec_helper'
NUM_OF_COUNTRIES = 249
describe ISO3166::Country do
  before { ISO3166.configuration.enable_currency_extension! }
  let(:country) { ISO3166::Country.search('US') }

  it 'allows to create a country object from a symbol representation of the alpha2 code' do
    country = described_class.new(:us)
    expect(country.data).not_to be_nil
  end

  it 'allows to create a country object from a lowercase alpha2 code' do
    country = described_class.new('us')
    expect(country.data).not_to be_nil
  end

  it 'allows countries to be compared' do
    c1 = ISO3166::Country.new('US')
    c2 = ISO3166::Country.new('US')
    c3 = ISO3166::Country.new('AU')
    expect(c1).to eq(c2)
    expect(c1).to_not eq(nil)
    expect(c1.hash).to eq(c2.hash)
    expect(c3.hash).to_not eq(c2.hash)

    hsh = {}
    hsh[c1] = 1
    hsh[c2] = 2
    expect(hsh.keys.count).to eq 1
  end

  it 'should return 3166 number' do
    expect(country.number).to eq('840')
  end

  it 'should return 3166 alpha2 code' do
    expect(country.alpha2).to eq('US')
  end

  it 'should return 3166 alpha3 code' do
    expect(country.alpha3).to eq('USA')
  end

  it 'should return 3166 iso_short_name' do
    expect(country.iso_short_name).to eq('United States of America')
  end

  it 'should return alternate names' do
    expect(country.unofficial_names).to eq(['United States', 'USA',
                                            'Vereinigte Staaten von Amerika',
                                            'États-Unis', 'Estados Unidos',
                                            'アメリカ合衆国', 'Verenigde Staten',
                                            'Соединенные Штаты Америки'])
  end

  it 'should return translations' do
    expect(country.translations).to be
    expect(country.translations['en']).to eq('United States')
  end

  it 'should return latitude' do
    expect(country.latitude).to eq(37.09024)
  end

  it 'should return longitude' do
    expect(country.longitude).to eq(-95.712891)
  end

  it 'should return bounds' do
    expect(country.bounds['northeast']['lat']).to eq(71.3577635769)
  end

  it 'should return continent' do
    expect(country.continent).to eq('North America')
  end

  it 'knows about whether or not the country uses postal codes' do
    expect(country.zip).to be_truthy
  end

  it 'knows when a country does not require postal codes' do
    antarctica = ISO3166::Country.search('AQ')
    expect(antarctica.postal_code).to eq(false)
  end

  it 'knows about the country postal code format' do
    expect(country.postal_code_format).to_not be_nil

    regex = Regexp.new(country.postal_code_format)
    expect(regex).to match('12345-6789')

    antarctica = ISO3166::Country.search('AQ')
    expect(antarctica.postal_code_format).to be_nil
  end

  it 'should return region' do
    expect(country.region).to eq('Americas')
  end

  it 'should return subregion' do
    expect(country.subregion).to eq('Northern America')
  end

  it 'should return world region' do
    expect(country.world_region).to eq('AMER')
  end

  context 'with Türkiye' do
    let(:country) { ISO3166::Country.search('TR') }

    it 'should indicate EMEA as the world region' do
      expect(country.world_region).to eq('EMEA')
    end

    it 'has iso_short_name Türkiye' do
      expect(country.iso_short_name).to eq('Türkiye')
    end

    it 'has iso_long_name Republic of Türkiye' do
      expect(country.iso_long_name).to eq('The Republic of Türkiye')
    end
  end

  context 'with Japan' do
    let(:country) { ISO3166::Country.search('JP') }

    it 'should indicate APAC as the world region' do
      expect(country.world_region).to eq('APAC')
    end
  end

  context 'with Belgium' do
    let(:country) { ISO3166::Country.search('BE') }

    it 'should return its local names based on its languages' do
      expect(country.local_names).to match_array(%w[België Belgique Belgien])
    end

    it 'should return its first local name' do
      expect(country.local_name).to eq('België')
    end
  end

  context 'with Brazil' do
    context 'with pt-BR translation' do
      before do
        ISO3166::Data.register(
          alpha2: 'BR2',
          iso_short_name: 'Brazil',
          languages_official: %w[pt-BR],
          translations: {
            'pt-BR' => 'Translation for pt-BR',
            'pt' => 'Translation for pt'
          }
        )
      end

      let(:country) { ISO3166::Country.search('BR2') }

      it 'should return its local name based on its language' do
        expect(country.local_names).to match_array(['Translation for pt-BR'])
      end

      after do
        ISO3166::Data.unregister('BR2')
      end
    end

    context 'without pt-BR translation' do
      before do
        ISO3166::Data.register(
          alpha2: 'BR2',
          iso_short_name: 'Brazil',
          languages_official: %w[pt-BR],
          translations: {
            'pt' => 'Translation for pt'
          }
        )
      end

      let(:country) { ISO3166::Country.search('BR2') }

      it 'should return its local name based on its language' do
        expect(country.local_names).to match_array(['Translation for pt'])
      end

      after do
        ISO3166::Data.unregister('BR2')
      end
    end
  end

  it 'should return ioc code' do
    expect(country.ioc).to eq('USA')
  end

  it 'should return UN/LOCODE' do
    expect(country.un_locode).to eq('US')
  end

  it 'should be identical to itself' do
    expect(country).to eq(ISO3166::Country.search('US'))
  end

  it 'should return language' do
    expect(country.languages[0]).to eq('en')
  end

  describe 'e164' do
    it 'should return country_code' do
      expect(country.country_code).to eq('1')
    end

    it 'should return national_destination_code_lengths' do
      expect(country.national_destination_code_lengths).to eq([3])
    end

    it 'should return national_number_lengths' do
      expect(country.national_number_lengths).to eq([10])
    end

    it 'should return international_prefix' do
      expect(country.international_prefix).to eq('011')
    end

    it 'should return national_prefix' do
      expect(country.national_prefix).to eq('1')
    end
  end

  describe 'subdivisions' do
    let(:virginia) { country.subdivisions['VA'] }
    it 'should return an empty hash for a country with no ISO3166-2' do
      expect(ISO3166::Country.search('VA').subdivisions.size).to eq(0)
    end

    it 'should return a hash with all sub divisions' do
      expect(country.subdivisions.size).to eq(57)
    end

    it '#states should be deprecated' do
      expect { country.states }.to output.to_stderr
    end

    it 'should be a subdivision object' do
      expect(virginia).to be_a(ISO3166::Subdivision)
    end

    it 'should have a name' do
      expect(virginia.name).to eq('Virginia')
    end

    it 'should have a code' do
      expect(virginia.code).to eq('VA')
    end

    it 'should behave like a hash' do
      expect(virginia['name']).to eq('Virginia')
    end
  end

  describe 'subdivision_types' do
    it 'should return an array of subdivision types' do
      expect(country.subdivision_types).to contain_exactly('district', 'state', 'outlying_area')
    end

    it 'should return an array of subdivision types even if there is only a single type' do
      expect(ISO3166::Country['LI'].subdivision_types).to contain_exactly('commune')
    end

    it 'should return an empty array if country has no subdivisions' do
      expect(ISO3166::Country['AS'].subdivisions?).to be_falsey
      expect(ISO3166::Country['AS'].subdivision_types).to eq([])
    end
  end

  describe 'subdivisions_of_types' do
    it 'given a single type, should return an array of subdivisions that match the type' do
      us_states = country.subdivisions_of_types(%w[state])
      expect(us_states.size).to eq(50)
      dc = country.subdivisions_of_types(%w[district])
      expect(dc.size).to eq(1)
    end

    it 'given multiple types, should return an array of subdivisions matching the types' do
      us_states_plus_dc = country.subdivisions_of_types(%w[state district])
      expect(us_states_plus_dc.size).to eq(51)
    end

    it 'given multiple types where at least one does not exist for that country, should work without issue' do
      us_states_plus_dc = country.subdivisions_of_types(%w[state district governorate])
      expect(us_states_plus_dc.size).to eq(51)
    end

    it 'given only types that do not exist for that country, should return an empty collection' do
      should_be_empty = ISO3166::Country['PT'].subdivisions_of_types(%w[state county])
      expect(should_be_empty).to be_empty
    end
  end

  describe 'humanized_subdivision_types' do
    it 'should return an array of humanized subdivision types' do
      expect(country.humanized_subdivision_types).to contain_exactly('District', 'State', 'Outlying area')
    end

    it 'should return an array of subdivision types even if there is only a single type' do
      expect(ISO3166::Country['LI'].humanized_subdivision_types).to contain_exactly('Commune')
    end

    it 'should return an empty array if country has no subdivisions' do
      expect(ISO3166::Country['AS'].subdivisions?).to be_falsey
      expect(ISO3166::Country['AS'].humanized_subdivision_types).to eq([])
    end
  end

  describe 'subdivision_names_with_codes' do
    it 'should return an alphabetized list of all subdivisions names with codes' do
      subdivisions = ISO3166::Country.search('EG').subdivision_names_with_codes
      expect(subdivisions).to be_an(Array)
      expect(subdivisions.first[0]).to be_a(String)
      expect(subdivisions.size).to eq(27)
      expect(subdivisions.first[0]).to eq('Alexandria')
    end

    it 'should return an alphabetized list of subdivision names translated to current locale with codes' do
      ISO3166.configuration.locales = %i[es de en]

      subdivisions = ISO3166::Country.search('EG').subdivision_names_with_codes(:es)
      expect(subdivisions).to be_an(Array)
      expect(subdivisions.first[0]).to be_a(String)
      expect(subdivisions.size).to eq(27)
      expect(subdivisions.first[0]).to eq('Al Iskandariyah')
    end
  end

  describe 'subdivision_names' do
    it 'should return an alphabetized list of all subdivisions names' do
      subdivisions = ISO3166::Country.search('EG').subdivision_names
      expect(subdivisions).to be_an(Array)
      expect(subdivisions.first).to be_a(String)
      expect(subdivisions.size).to eq(27)
      expect(subdivisions.first).to eq('Alexandria')
    end

    it 'should return an alphabetized list of subdivision names translated to current locale with codes' do
      ISO3166.configuration.locales = %i[es de en]

      subdivisions = ISO3166::Country.search('EG').subdivision_names(:es)
      expect(subdivisions).to be_an(Array)
      expect(subdivisions.first).to be_a(String)
      expect(subdivisions.size).to eq(27)
      expect(subdivisions.first).to eq('Al Iskandariyah')
    end
  end

  describe 'valid?' do
    it 'should return true if country is valid' do
      expect(ISO3166::Country.new('US')).to be_valid
    end

    it 'should return false if country is invalid' do
      expect(ISO3166::Country.new({})).not_to be_valid
    end
  end

  describe 'new' do
    it 'should return new country object when a valid alpha2 string is passed' do
      expect(ISO3166::Country.new('US')).to be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 string is passed' do
      expect(ISO3166::Country.new('fubar')).to be_nil
    end

    it 'should return new country object when a valid alpha2 symbol is passed' do
      expect(ISO3166::Country.new(:us)).to be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 symbol is passed' do
      expect(ISO3166::Country.new(:fubar)).to be_nil
    end
  end

  describe 'compare' do
    it 'should compare itself with other countries by its name' do
      canada = ISO3166::Country.search('CA')
      mexico = ISO3166::Country.search('MX')
      expect(mexico <=> canada).to eq(1)
      expect(canada <=> mexico).to eq(-1)
    end
  end

  describe 'all' do
    it 'should return an array list of all countries' do
      countries = ISO3166::Country.all
      expect(countries).to be_an(Array)
      expect(countries.first).to be_an(ISO3166::Country)
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end

    it 'should allow to customize each country representation passing a block to the method' do
      countries = ISO3166::Country.all { |country, data| [data['iso_short_name'], country, data['country_code']] }
      expect(countries).to be_an(Array)
      expect(countries.first).to be_an(Array)
      expect(countries.first.size).to eq(3)
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end
  end

  describe 'all_translated' do
    it 'should return an alphabetized list of all country names translated to the selected locale' do
      countries = ISO3166::Country.all_translated('fr')
      expect(countries).to be_an(Array)
      expect(countries.first).to be_a(String)
      expect(countries.first).to eq('Andorre')
      # countries missing the desired locale will not be added to the list
      # so all 250 countries may not be returned, 'fr' returns 249, for example
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end

    it 'should return an alphabetized list of all country names in English if no locale is passed' do
      countries = ISO3166::Country.all_translated
      expect(countries).to be_an(Array)
      expect(countries.first).to be_a(String)
      expect(countries.first).to eq('Andorra')
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end

    context 'with custom countries' do
      before do
        ISO3166::Data.register(
          alpha2: 'XX',
          iso_short_name: 'Custom Country',
          translations: { 'en' => 'Custom Country' }
        )
      end

      it 'should include custom registered countries' do
        custom_country = ISO3166::Country.find_by_alpha2('XX')[1]
        countries = ISO3166::Country.all_translated
        expect(countries).to include(custom_country['iso_short_name'])
      end

      after do
        ISO3166::Data.unregister('XX')
      end
    end
  end

  describe 'all_names_with_codes' do
    require 'active_support/core_ext/string/output_safety'
    it 'should return an alphabetized list of all country names with ISOCODE alpha2' do
      countries = ISO3166::Country.all_names_with_codes
      expect(countries).to be_an(Array)
      expect(countries.first[0]).to be_a(String)
      expect(countries.first[0]).to eq('Afghanistan')
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
      expect(countries.any? { |pair| !pair[0].html_safe? }).to eq(false)
    end

    it 'should return an alphabetized list of all country names translated to current locale with ISOCODE alpha2' do
      ISO3166.configuration.locales = %i[es de en]

      countries = ISO3166::Country.all_names_with_codes(:es)
      expect(countries).to be_an(Array)
      expect(countries.first[0]).to be_a(String)
      expect(countries.first[0]).to eq('Afganistán')
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end
  end

  describe 'all_names_with_codes_without_active_support' do
    it 'should return an alphabetized list of all country names with ISOCODE alpha2' do
      countries = ISO3166::Country.all_names_with_codes
      expect(countries).to be_an(Array)
      expect(countries.first[0]).to be_a(String)
      expect(countries.first[0]).to eq('Afghanistan')
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end

    it 'should return an alphabetized list of all country names translated to current locale with ISOCODE alpha2' do
      ISO3166.configuration.locales = %i[es de en]

      countries = ISO3166::Country.all_names_with_codes(:es)
      expect(countries).to be_an(Array)
      expect(countries.first[0]).to be_a(String)
      expect(countries.first[0]).to eq('Afganistán')
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end
  end

  describe 'translation' do
    it 'should return the localized name for a country to the selected locale' do
      ISO3166.configuration.locales = %i[es de en]
      countries = ISO3166::Country.new(:de).translation('de')
      expect(countries).to be_an(String)
      expect(countries).to eq('Deutschland')
    end

    it 'should return the localized name for a country in English' do
      countries = ISO3166::Country.new(:de).translation
      expect(countries).to be_an(String)
      expect(countries).to eq('Germany')
    end

    it 'should return nil when a translation is not found' do
      countries = ISO3166::Country.new(:de).translation('xxx')
      expect(countries).to be_nil
    end

    context 'should return variant locales' do
      it 'should return different value for Chinese variants' do
        ISO3166.configuration.locales = %i[zh-cn zh-hk zh-tw]
        name_cn = ISO3166::Country['TW'].translation('zh-cn')
        name_hk = ISO3166::Country['TW'].translation('zh-hk')
        name_tw = ISO3166::Country['TW'].translation('zh-tw')
        expect([name_cn, name_hk, name_tw].uniq.size).to eql 3
      end

      it 'should return different value for Portuguese variants' do
        ISO3166.configuration.locales = %i[pt pt-br]
        name_pt = ISO3166::Country['SG'].translation('pt')
        name_br = ISO3166::Country['SG'].translation('pt-br')
        expect([name_pt, name_br].uniq.size).to eql 2
      end
    end
  end

  describe 'translations' do
    it 'should return an hash of all country names translated to the selected locale' do
      countries = ISO3166::Country.translations('fr')
      expect(countries).to be_an(Hash)
      expect(countries.first[0]).to eq('AD')
      expect(countries.first).to eq(%w[AD Andorre])
      # countries missing the desired locale will not be added to the list
      # so all 250 countries may not be returned, 'fr' returns 249, for example
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end

    it 'should return an hash of all country names in English if no locale is passed' do
      countries = ISO3166::Country.translations
      expect(countries).to be_an(Hash)
      expect(countries.first[0]).to eq('AD')
      expect(countries.first).to eq(%w[AD Andorra])
      expect(countries.size).to eq(NUM_OF_COUNTRIES)
    end
  end

  describe 'countries' do
    it 'should be the same as all' do
      expect(ISO3166::Country.countries).to eq(ISO3166::Country.all)
    end
  end

  describe 'search' do
    it 'should return new country object when a valid alpha2 string is passed' do
      expect(ISO3166::Country.search('US')).to be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 string is passed' do
      expect(ISO3166::Country.search('fubar')).to be_nil
    end

    it 'should return new country object when a valid alpha2 symbol is passed' do
      expect(ISO3166::Country.search(:us)).to be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 symbol is passed' do
      expect(ISO3166::Country.search(:fubar)).to be_nil
    end
  end

  describe 'currency' do
    it 'should return an instance of Currency' do
      expect(country.currency).to be_a(Money::Currency)
    end

    it 'should allow access to symbol' do
      expect(country.currency.symbol).to eq('$')
    end
  end

  describe 'codes' do
    it 'returns a hash with the data of the country' do
      expect(ISO3166::Country.codes).to be_a Array
      expect(ISO3166::Country.codes.size).to eq(NUM_OF_COUNTRIES)
    end
  end

  describe 'find_all_by' do
    context 'when searchead attribute equals the given value' do
      let(:spain_data) { ISO3166::Country.find_all_by('alpha2', 'ES') }

      it 'returns a hash with the data of the country' do
        expect(spain_data).to be_a Hash
        expect(spain_data.keys.size).to eq(1)
      end
    end

    context 'when searchead attribute is list and one of its elements equals the given value' do
      let(:spain_data) { ISO3166::Country.find_all_by('languages', 'en') }

      it 'returns a hash with the data of the country' do
        expect(spain_data).to be_a Hash
        expect(spain_data.size).to be > 1
      end
    end

    it 'also finds results if the given values is not upcased/downcased properly' do
      spain_data = ISO3166::Country.find_all_by('alpha2', 'es')
      expect(spain_data).to be_a Hash
      expect(spain_data.keys.size).to eq(1)
    end

    it 'also finds results if the attribute is given as a symbol' do
      spain_data = ISO3166::Country.find_all_by(:alpha2, 'ES')
      expect(spain_data).to be_a Hash
      expect(spain_data.keys.size).to eq(1)
    end

    it 'casts the given value to a string to perform the search' do
      spain_data = ISO3166::Country.find_all_by(:country_code, 34)
      expect(spain_data).to be_a Hash
      expect(spain_data.keys).to eq(['ES'])
    end

    it 'also performs searches with regexps and forces it to ignore case' do
      spain_data = ISO3166::Country.find_all_by(:unofficial_names, /Españ/)
      expect(spain_data).to be_a Hash
      expect(spain_data.keys).to eq(['ES'])
    end

    it 'finds country from a subdivision name' do
      gb_data = ISO3166::Country.find_all_by(:subdivision_names, 'Scotland')
      expect(gb_data).to be_a Hash
      expect(gb_data.keys).to eq(['GB'])
    end

    it 'performs reasonably' do
      start = Time.now
      250.times do
        lookup = ['ZM', 'ZMB', 'Zambia', 'US', 'USA', 'United States'].sample
        case lookup.length
        when 2 then ISO3166::Country.find_all_by(:alpha2, lookup)
        when 3 then ISO3166::Country.find_all_by(:alpha3, lookup)
        else ISO3166::Country.find_all_by(:iso_short_name, lookup)
        end
      end
      expect(Time.now - start).to be < 1
    end
  end

  describe 'hash finder methods' do
    context "when search name in 'iso_short_name'" do
      subject { ISO3166::Country.find_by_iso_short_name('Poland') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context "when search lowercase name in 'iso_short_name'" do
      subject { ISO3166::Country.find_by_iso_short_name('poland') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context "when search name with comma in 'iso_short_name'" do
      subject { ISO3166::Country.find_by_iso_short_name(country_name) }

      context 'with Republic of Korea' do
        let(:country_name) { 'Korea, Republic of' }
        it 'should return' do
          expect(subject.first).to eq('KR')
        end
      end

      context 'with Bolivia' do
        let(:country_name) { 'Bolivia, Plurinational State of' }
        it 'should return' do
          expect(subject.first).to eq('BO')
        end
      end

      context 'with Bonaire' do
        let(:country_name) { 'Bonaire, Sint Eustatius and Saba' }
        it 'should return' do
          expect(subject.first).to eq('BQ')
        end
      end
    end

    context 'when search lowercase multibyte name found' do
      subject { ISO3166::Country.find_country_by_unofficial_names('россия') }

      it 'should be a country instance' do
        expect(subject).to be_a(ISO3166::Country)
        expect(subject.alpha2).to eq('RU')
      end
    end

    context 'when search lowercase multibyte name found' do
      subject { ISO3166::Country.find_country_by_unofficial_names(/россия/) }

      it 'should be a country instance' do
        expect(subject).to be_a(ISO3166::Country)
        expect(subject.alpha2).to eq('RU')
      end
    end

    context 'when accents are not used' do
      subject { ISO3166::Country.find_country_by_unofficial_names('emirats Arabes Unis') }

      it 'should be a country instance' do
        expect(subject).to be_a(ISO3166::Country)
        expect(subject.alpha2).to eq('AE')
      end
    end

    context "when search name in 'unofficial_names'" do
      subject { ISO3166::Country.find_by_unofficial_names('Polonia') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context "when search name in 'subdivision_names'" do
      subject { ISO3166::Country.find_by_subdivision_names('Scotland') }
      it 'should return' do
        expect(subject.first).to eq('GB')
      end
    end

    context "when search name in 'translated_names'" do
      before do
        ISO3166.configure do |config|
          config.locales = [:bs]
        end
      end
      subject { ISO3166::Country.find_by_translated_names('Poljska') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context 'when finding by invalid attribute' do
      it 'should raise an error' do
        expect { ISO3166::Country.find_by_invalid('invalid') }.to(
          raise_error(RuntimeError, "Invalid attribute name 'invalid'")
        )
      end
    end

    context 'when using find_all method' do
      let(:list) { ISO3166::Country.find_all_by_currency('USD') }

      it 'should be an Array of Arrays' do
        expect(list).to be_a(Array)
        expect(list.first).to be_a(Array)
      end
    end

    context 'when using find_by method' do
      subject { ISO3166::Country.find_by_alpha3('CAN') }
      it 'should return' do
        expect(subject.length).to eq 2
        expect(subject.first).to be_a(String)
        expect(subject.last).to be_a(Hash)
      end
    end
  end

  describe 'country finder methods' do
    context 'when search name found' do
      let(:uk) { ISO3166::Country.find_country_by_unofficial_names('United Kingdom') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    context 'when search lowercase name found' do
      let(:uk) { ISO3166::Country.find_country_by_unofficial_names('united kingdom') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    context 'when the search term contains comma' do
      let(:korea) { ISO3166::Country.find_country_by_unofficial_names('Korea, Republic of') }

      it 'should be a country instance' do
        expect(korea).to be_a(ISO3166::Country)
        expect(korea.alpha2).to eq('KR')
      end
    end

    context 'when search translation found' do
      before do
        ISO3166.configure do |config|
          config.locales = [:bs]
        end
      end
      let(:uk) { ISO3166::Country.find_country_by_translated_names('Velika Britanija') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    describe '#find_country_by_any_name' do
      context 'when search name found' do
        let(:uk) { ISO3166::Country.find_country_by_any_name('United Kingdom') }

        it 'should be a country instance' do
          expect(uk).to be_a(ISO3166::Country)
          expect(uk.alpha2).to eq('GB')
        end
      end

      context 'when search lowercase name found' do
        let(:uk) { ISO3166::Country.find_country_by_any_name('united kingdom') }

        it 'should be a country instance' do
          expect(uk).to be_a(ISO3166::Country)
          expect(uk.alpha2).to eq('GB')
        end
      end

      context 'when the search term contains comma' do
        let(:korea) { ISO3166::Country.find_country_by_any_name('Korea, Republic of') }

        it 'should be a country instance' do
          expect(korea).to be_a(ISO3166::Country)
          expect(korea.alpha2).to eq('KR')
        end
      end

      context 'when search translation found' do
        before do
          ISO3166.configure do |config|
            config.locales = [:bs]
          end
        end
        let(:uk) { ISO3166::Country.find_country_by_any_name('Velika Britanija') }

        it 'should be a country instance' do
          expect(uk).to be_a(ISO3166::Country)
          expect(uk.alpha2).to eq('GB')
        end
      end
    end

    context 'sanity check for #771' do
      let(:turkey) { ISO3166::Country.find_country_by_any_name('Turkey') }

      it 'should be a country instance' do
        expect(turkey).to be_a(ISO3166::Country)
        expect(turkey.alpha2).to eq('TR')
      end
    end

    context 'regression test for #746' do
      let(:no_country) { ISO3166::Country.find_country_by_any_name(nil) }

      it 'should not be a country instance' do
        expect(no_country).to_not be_a(ISO3166::Country)
        expect(no_country).to eq nil
      end
    end

    context 'regression test for #388/#746/#776' do
      before do
        ISO3166.configure do |config|
          config.locales = %i[af am ar as az be bg bn br bs ca cs cy da de dz el en
                              eo es et eu fa fi fo fr ga gl gu he hi hr hu hy ia id
                              is it ja ka kk km kn ko ku lt lv mi mk ml mn mr ms mt
                              nb ne nl nn oc or pa pl ps pt ro ru rw si sk sl so sq
                              sr sv sw ta te th ti tk tl tr tt ug uk ve vi wa wo xh
                              zh zu]
        end
      end

      let(:no_country) { ISO3166::Country.find_country_by_translated_names(nil) }
      let(:zimbabwe) { ISO3166::Country['ZW'] }

      it 'should not be a country instance' do
        expect(no_country).to_not be_a(ISO3166::Country)
        expect(no_country).to eq nil
      end

      it 'translated_names should not include nil values' do
        expect(zimbabwe.translation('no')).to be_nil
        expect(zimbabwe.translated_names).not_to include(nil)
      end
    end

    context 'when attempting to search by translations hash' do
      let(:uk) { ISO3166::Country.find_country_by_translations({}) }

      it 'should be a country instance' do
        expect { uk }.to raise_error(RuntimeError)
      end
    end

    context 'when search name not found' do
      let(:bogus) { ISO3166::Country.find_country_by_unofficial_names('Does not exist') }

      it 'should be a country instance' do
        expect(bogus).to eq(nil)
      end
    end

    # Spot checks #243
    context 'when search name not found' do
      let(:belgium) { ISO3166::Country.find_country_by_unofficial_names('Belgium') }

      it 'should be a country instance' do
        expect(belgium.alpha2).to eq('BE')
      end
    end

    # Spot checks #240
    context 'when search name not found' do
      let(:canada) { ISO3166::Country.find_country_by_unofficial_names('Canada') }

      it 'should be a country instance' do
        expect(canada.alpha2).to eq('CA')
      end
    end

    # Spot checks #241
    context 'when search name not found' do
      let(:israel) { ISO3166::Country.find_country_by_unofficial_names('Israel') }

      it 'should be a country instance' do
        expect(israel.alpha2).to eq('IL')
      end
    end

    # Spot checks #241
    context 'when search name not found' do
      let(:israel) { ISO3166::Country.find_by_iso_short_name('Israel') }

      it 'should be a country instance' do
        expect(israel[0]).to eq('IL')
      end
    end

    # Spot checks #241
    context 'when search name not found' do
      let(:israel) { ISO3166::Country.find_all_by(:iso_short_name, 'Israel') }

      it 'should be a country instance' do
        expect(israel.size).to eq(1)
        expect(israel.first[0]).to eq('IL')
      end
    end

    context 'when finding by invalid attribute' do
      it 'should raise an error' do
        expect { ISO3166::Country.find_country_by_invalid('invalid') }.to(
          raise_error(RuntimeError, "Invalid attribute name 'invalid'")
        )
      end
    end

    context 'when using find_all method' do
      let(:list) { ISO3166::Country.find_all_countries_by_currency('USD') }

      it 'should be an Array of Country objects' do
        expect(list).to be_a(Array)
        expect(list.first).to be_a(ISO3166::Country)
      end
    end

    context 'when using find_by method' do
      let(:country) { ISO3166::Country.find_country_by_alpha3('CAN') }

      it 'should be a single country object' do
        expect(country).to be_a(ISO3166::Country)
      end
    end
  end

  describe 'finder methods respond_to_missing?' do
    subject { ISO3166::Country.respond_to?(method_name) }
    describe 'find_all_by' do
      context 'find by a valid Country attribute' do
        let(:method_name) { :find_all_by_currency }
        it { is_expected.to be true }
      end

      context 'find by an invalid attribute' do
        let(:method_name) { :find_all_by_invalid }
        it { is_expected.to be false }
      end
    end

    describe 'hash finder methods' do
      context 'find by a valid Country attribute' do
        let(:method_name) { :find_by_iso_short_name }
        it { is_expected.to be true }
      end

      context 'find by an invalid attribute' do
        let(:method_name) { :find_by_invalid }
        it { is_expected.to be false }
      end
    end

    describe 'country finder methods' do
      context 'find country by a valid Country attribute' do
        let(:method_name) { :find_country_by_alpha3 }
        it { is_expected.to be true }
      end

      context 'find by an invalid attribute' do
        let(:method_name) { :find_country_by_invalid }
        it { is_expected.to be false }
      end
    end
  end

  describe 'Norway' do
    let(:norway) { ISO3166::Country.search('NO') }

    it 'should have a currency' do
      expect(norway.currency).to be_a(Money::Currency)
    end
  end

  describe 'Guernsey' do
    let(:guernsey) { ISO3166::Country.search('GG') }

    it 'should have a currency' do
      expect(guernsey.currency.iso_code).to eq('GBP')
    end
  end

  describe 'Languages' do
    let(:german_speaking_countries) { ISO3166::Country.find_all_countries_by_languages('de') }

    it 'should find countries by language' do
      expect(german_speaking_countries.size).to eq(6)
    end
  end

  describe 'in_eu?' do
    let(:netherlands) { ISO3166::Country.search('NL') }

    it 'should return false for countries without eu_member flag' do
      expect(country.in_eu?).to be_falsey
    end

    it 'should return true for countries with eu_member flag set to true' do
      expect(netherlands.in_eu?).to be_truthy
    end
  end

  describe 'in_eea?' do
    let(:netherlands) { ISO3166::Country.search('NL') }

    it 'should return false for countries without eea_member flag' do
      expect(country.in_eea?).to be_falsey
    end

    it 'should return true for countries with eea_member flag set to true' do
      expect(netherlands.in_eea?).to be_truthy
    end
  end

  describe 'in_esm?' do
    let(:netherlands) { ISO3166::Country.search('NL') }
    let(:switzerland) { ISO3166::Country.search('CH') }

    it 'should return false for countries without esm_member or eea_member flag' do
      expect(country.in_esm?).to be_falsey
    end

    it 'should return true for countries with eea_member flag set to true' do
      expect(netherlands.in_esm?).to be_truthy
    end

    it 'should return true for countries with esm_member flag set to true' do
      expect(switzerland.in_esm?).to be_truthy
    end
  end

  describe 'in_eu_vat?' do
    let(:netherlands) { ISO3166::Country.search('NL') }
    let(:guadeloupe) { ISO3166::Country.search('GP') }
    let(:monaco) { ISO3166::Country.search('MC') }

    it 'should return false for countries without euvat_member or eu_member flag' do
      expect(country.in_eu_vat?).to be_falsey
    end

    it 'should return true for countries with eu_member flag set to true' do
      expect(netherlands.in_eu_vat?).to be_truthy
    end

    it 'should return false for countries with euvat_member flag set to false' do
      expect(guadeloupe.in_eu_vat?).to be_falsey
    end

    it 'should return true for countries with euvat_member flag set to true' do
      expect(monaco.in_eu_vat?).to be_truthy
    end
  end

  describe 'gec' do
    it 'should return the country\'s GEC code' do
      expect(ISO3166::Country.new('NA').gec).to eql 'WA'
    end

    it 'should return nil if the country does not have a GEC code' do
      expect(ISO3166::Country.new('UM').gec).to eql nil
    end
  end

  describe 'to_s' do
    it 'should return the country iso_short_name' do
      expect(ISO3166::Country.new('GB').to_s).to eq('United Kingdom of Great Britain and Northern Ireland')
    end
  end

  describe 'VAT rates' do
    let(:belgium) { ISO3166::Country.search('BE') }

    it 'should not return a vat_rate for countries without federal VAT' do
      expect(country.vat_rates).to eq(nil)
    end

    it 'should contain all keys for vat_rates' do
      expect(belgium.vat_rates).to be_a(Hash)
      expect(belgium.vat_rates.keys).to eq(%w[standard reduced super_reduced parking])
    end

    it 'should return an array of reduced vat rates' do
      expect(belgium.vat_rates['reduced']).to be_an(Array)
      expect(belgium.vat_rates['reduced']).to eq([6, 12])
    end
  end

  describe 'ISO3166::Country()' do
    it 'should return same object if instance of ISO3166::Country given' do
      expect(ISO3166::Country(country)).to eq country
    end

    it 'should return country if instance of String given' do
      expect(ISO3166::Country('us')).to eq country
    end

    it 'should return country if not convertable input given' do
      expect do
        ISO3166::Country(42)
      end.to raise_error(TypeError, /can't convert ([A-z]+) into ISO3166::Country/)
    end
  end

  describe 'Added country names to search by' do
    it 'should return country code for Democratic Republic of the Congo' do
      expect(ISO3166::Country.find_country_by_unofficial_names('Democratic Republic of the Congo').alpha2).to eq 'CD'
    end
    it 'should return country code for Ivory Coast' do
      expect(ISO3166::Country.find_country_by_unofficial_names('Ivory Coast').alpha2).to eq 'CI'
    end
    it 'should return Pakistan code for Guinea Bissau' do
      expect(ISO3166::Country.find_country_by_unofficial_names('Guinea Bissau').alpha2).to eq 'GW'
    end
    it 'should return Pakistan code for St Kitts and Nevis' do
      expect(ISO3166::Country.find_country_by_unofficial_names('St Kitts and Nevis').alpha2).to eq 'KN'
    end
    it 'should return Pakistan code for St Lucia' do
      expect(ISO3166::Country.find_country_by_unofficial_names('St Lucia').alpha2).to eq 'LC'
      expect(ISO3166::Country.find_country_by_unofficial_names('St. Lucia').alpha2).to eq 'LC'
    end
    it 'should return Pakistan code for Turks and Caicos' do
      expect(ISO3166::Country.find_country_by_unofficial_names('Turks and Caicos').alpha2).to eq 'TC'
    end
    it 'should return Pakistan code for St Vincent Grenadines' do
      expect(ISO3166::Country.find_country_by_unofficial_names('St Vincent Grenadines').alpha2).to eq 'VC'
      expect(ISO3166::Country.find_country_by_unofficial_names('St. Vincent Grenadines').alpha2).to eq 'VC'
    end
    it 'should return country code for Palestinian Authority' do
      expect(ISO3166::Country.find_country_by_unofficial_names('Palestinian Authority').alpha2).to eq 'PS'
    end
  end

  describe 'Emoji' do
    it 'has an emoji flag' do
      expect(country.emoji_flag).to eq '🇺🇸'
    end
  end

  describe '#un_locode' do
    let(:countries) { ISO3166::Country.all }

    it 'should have two letter un_locode for each country' do
      expect(countries.all? { |country| !country.un_locode.nil? }).to be
      expect(countries.all? { |country| country.un_locode.length == 2 }).to be
    end
  end

  describe '.pluck' do
    let(:args) { [] }

    subject { ISO3166::Country.pluck(*args) }

    it 'returns empty arrays' do
      expect(subject.first).to be_empty
      expect(subject.last).to be_empty
    end

    context 'when asking for alpha2, alpha3 and iso_short_name' do
      let(:args) { %i[alpha2 alpha3 iso_short_name] }

      it 'returns the correct values' do
        expect(subject.first).to eq(%w[AD AND Andorra])
        expect(subject.last).to eq(%w[ZW ZWE Zimbabwe])
      end
    end
  end
end
