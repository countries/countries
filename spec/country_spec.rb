# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ISO3166::Country do

  let(:country) { ISO3166::Country.search('US') }

  it 'allows to create a country object from a symbol representation of the alpha2 code' do
    country = described_class.new(:us)
    expect(country.data).not_to be_nil
  end

  it 'allows to create a country object from a lowercase alpha2 code' do
    country = described_class.new('us')
    expect(country.data).not_to be_nil
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

  it 'should return 3166 name' do
    expect(country.name).to eq('United States')
  end

  it 'should return alternate names' do
    expect(country.names).to eq(['United States of America', 'Vereinigte Staaten von Amerika', 'États-Unis', 'Estados Unidos', 'アメリカ合衆国', 'Verenigde Staten'])
  end

  it 'should return translations' do
    expect(country.translations).to be
    expect(country.translations['en']).to eq('United States')
  end

  it 'should return latitude' do
    expect(country.latitude).to eq('38 00 N')
  end

  it 'should return longitude' do
    expect(country.longitude).to eq('97 00 W')
  end

  it 'should return the decimal Latitude' do
    expect(country.latitude_dec).to eq('39.44325637817383')
  end

  it 'should return the decimal Longitude' do
    expect(country.longitude_dec).to eq('-98.95733642578125')
  end

  it 'should return continent' do
    expect(country.continent).to eq('North America')
  end

  it 'knows about whether or not the country uses postal codes' do
    expect(country.zip).to be_truthy
  end

  it 'knows when a country does not require postal codes' do
    ireland = ISO3166::Country.search('IE')
    expect(ireland.postal_code).to eq(false)
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

  context 'with Turkey' do
    let(:country) { ISO3166::Country.search('TR') }

    it 'should indicate EMEA as the world region' do
      expect(country.world_region).to eq('EMEA')
    end
  end

  context 'with Japan' do
    let(:country) { ISO3166::Country.search('JP') }

    it 'should indicate APAC as the world region' do
      expect(country.world_region).to eq('APAC')
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
    it 'should return an empty hash for a country with no ISO3166-2' do
      expect(ISO3166::Country.search('VA').subdivisions.size).to eq(0)
    end

    it 'should return a hash with all sub divisions' do
      expect(country.subdivisions.size).to eq(60)
    end

    it 'should be available through states' do
      expect(country.states.size).to eq(60)
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

  describe 'all' do
    it 'should return an arry list of all countries' do
      countries = ISO3166::Country.all
      expect(countries).to be_an(Array)
      expect(countries.first).to be_an(Array)
      expect(countries.size).to eq(250)
    end

    it 'should allow to customize each country representation passing a block to the method' do
      countries = ISO3166::Country.all { |country, data| [data['name'], country, data['country_code']] }
      expect(countries).to be_an(Array)
      expect(countries.first).to be_an(Array)
      expect(countries.first.size).to eq(3)
      expect(countries.size).to eq(250)
    end
  end

  describe 'all_translated' do
    it 'should return an alphabetized list of all country names translated to the selected locale' do
      countries = ISO3166::Country.all_translated('fr')
      expect(countries).to be_an(Array)
      expect(countries.first).to be_a(String)
      expect(countries.first).to eq('Afghanistan')
      # countries missing the desired locale will not be added to the list
      # so all 250 countries may not be returned, 'fr' returns 249, for example
      expect(countries.size).to eq(249)
    end

    it 'should return an alphabetized list of all country names in English if no locale is passed' do
      countries = ISO3166::Country.all_translated
      expect(countries).to be_an(Array)
      expect(countries.first).to be_a(String)
      expect(countries.first).to eq('Afghanistan')
      expect(countries.size).to eq(249)
    end
  end

  describe 'translation' do
    it 'should return the localized name for a country to the selected locale' do
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
  end

  describe 'translations' do
    it 'should return an hash of all country names translated to the selected locale' do
      countries = ISO3166::Country.translations('fr')
      expect(countries).to be_an(Hash)
      expect(countries.first[0]).to eq('AF')
      expect(countries.first).to eq(%w(AF Afghanistan))
      # countries missing the desired locale will not be added to the list
      # so all 250 countries may not be returned, 'fr' returns 249, for example
      expect(countries.size).to eq(249)
    end

    it 'should return an hash of all country names in English if no locale is passed' do
      countries = ISO3166::Country.translations
      expect(countries).to be_an(Hash)
      expect(countries.first[0]).to eq('AF')
      expect(countries.first).to eq(%w(AF Afghanistan))
      expect(countries.size).to eq(249)
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
      expect(country.currency).to be_a(ISO4217::Currency)
    end

    it 'should allow access to symbol' do
      expect(country.currency[:symbol]).to eq('$')
    end
  end

  describe 'Country class' do
    context "when loaded via 'iso3166' existance" do
      subject { defined?(Country) }

      it { is_expected.to be_falsey }
    end

    context "when loaded via 'countries'" do
      before { require 'countries' }

      describe 'existance' do
        subject { defined?(Country) }

        it { is_expected.to be_truthy }
      end

      describe 'superclass' do
        subject { Country.superclass }

        it { is_expected.to eq(ISO3166::Country) }
      end

      describe 'to_s' do
        it 'should return the country name' do
          expect(Country.new('GB').to_s).to eq('United Kingdom')
        end
      end
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
      spain_data = ISO3166::Country.find_all_by(:names, /Españ/)
      expect(spain_data).to be_a Hash
      expect(spain_data.keys).to eq(['ES'])
    end
  end

  describe 'hash finder methods' do
    context "when search name in 'name'" do
      subject { ISO3166::Country.find_by_name('Poland') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context "when search lowercase name in 'name'" do
      subject { ISO3166::Country.find_by_name('poland') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context "when search name in 'names'" do
      subject { ISO3166::Country.find_by_name('Polonia') }
      it 'should return' do
        expect(subject.first).to eq('PL')
      end
    end

    context 'when finding by invalid attribute' do
      it 'should raise an error' do
        expect { ISO3166::Country.find_by_invalid('invalid') }.to raise_error
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
      let(:uk) { ISO3166::Country.find_country_by_name('United Kingdom') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    context 'when search lowercase name found' do
      let(:uk) { ISO3166::Country.find_country_by_name('united kingdom') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    context 'when search translation found' do
      let(:uk) { ISO3166::Country.find_country_by_translated_names('Velika Britanija') }

      it 'should be a country instance' do
        expect(uk).to be_a(ISO3166::Country)
        expect(uk.alpha2).to eq('GB')
      end
    end

    context 'when search name not found' do
      let(:bogus) { ISO3166::Country.find_country_by_name('Does not exist') }

      it 'should be a country instance' do
        expect(bogus).to eq(nil)
      end
    end

    # Spot checks #243
    context 'when search name not found' do
      let(:belgium) { ISO3166::Country.find_country_by_name('Belgium') }

      it 'should be a country instance' do
        expect(belgium.alpha2).to eq('BE')
      end
    end

    # Spot checks #240
    context 'when search name not found' do
      let(:canada) { ISO3166::Country.find_country_by_name('Canada') }

      it 'should be a country instance' do
        expect(canada.alpha2).to eq('CA')
      end
    end

    # Spot checks #241
    context 'when search name not found' do
      let(:iraq) { ISO3166::Country.find_country_by_name('Israel') }

      it 'should be a country instance' do
        expect(iraq.alpha2).to eq('IL')
      end
    end

    context 'when finding by invalid attribute' do
      it 'should raise an error' do
        expect { ISO3166::Country.find_country_by_invalid('invalid') }.to raise_error
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

  describe 'names in Data' do
    it 'should be unique (to allow .find_by_name work properly)' do
      names = ISO3166::Country::Data.map do |_k, v|
        [v['name'], v['names']].flatten.uniq
      end.flatten

      expect(names.size).to eq(names.uniq.size)
    end
  end

  describe 'Norway' do
    let(:norway) { ISO3166::Country.search('NO') }

    it 'should have a currency' do
      expect(norway.currency).to be_a(ISO4217::Currency)
    end
  end

  describe 'Guernsey' do
    let(:guernsey) { ISO3166::Country.search('GG') }

    it 'should have a currency' do
      expect(guernsey.currency.code).to eq('GBP')
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

  describe 'gec' do
    it 'should return the country\'s GEC code' do
      expect(ISO3166::Country.new('NA').gec).to eql 'WA'
    end

    it 'should return nil if the country does not have a GEC code' do
      expect(ISO3166::Country.new('AN').gec).to eql nil
    end
  end

  describe 'to_s' do
    it 'should return the country name' do
      expect(ISO3166::Country.new('GB').to_s).to eq('United Kingdom')
    end
  end

  describe 'VAT rates' do
    let(:belgium) { ISO3166::Country.search('BE') }

    it 'should not return a vat_rate for countries without federal VAT' do
      expect(country.vat_rates).to eq(nil)
    end

    it 'should contain all keys for vat_rates' do
      expect(belgium.vat_rates).to be_a(Hash)
      expect(belgium.vat_rates.keys).to eq(%w(standard reduced super_reduced parking))
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
      end.to raise_error(TypeError, "can't convert Fixnum into ISO3166::Country")
    end
  end
end
