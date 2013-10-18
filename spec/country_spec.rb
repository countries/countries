# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ISO3166::Country do

  let(:country) { ISO3166::Country.search('US') }

  it 'allows to create a country object from a symbol representation of the alpha2 code' do
    country = described_class.new(:us)
    country.data.should_not be_nil
  end

  it 'allows to create a country object from a lowercase alpha2 code' do
    country = described_class.new("us")
    country.data.should_not be_nil
  end

  it 'should return 3166 number' do
    country.number.should == '840'
  end

  it 'should return 3166 alpha2 code' do
    country.alpha2.should == 'US'
  end

  it 'should return 3166 alpha3 code' do
    country.alpha3.should == 'USA'
  end

  it 'should return 3166 name' do
    country.name.should == 'United States'
  end

  it 'should return alternate names' do
    country.names.should == ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos", "アメリカ合衆国", "Verenigde Staten"]
  end

  it 'should return translations' do
    country.translations.should be
    country.translations["en"].should == "United States of America"
  end

  it 'should return latitude' do
    country.latitude.should == '38 00 N'
  end

  it 'should return longitude' do
    country.longitude.should == '97 00 W'
  end

  it "should return continent" do
    country.continent.should == "North America"
  end

  it 'should return region' do
    country.region.should == 'Americas'
  end

  it 'should return subregion' do
    country.subregion.should == 'Northern America'
  end

  it 'should return ioc code' do
    country.ioc.should == 'USA'
  end

  it 'should return UN/LOCODE' do
    country.un_locode.should == 'US'
  end

  it 'should be identical to itself' do
    country.should == ISO3166::Country.search('US')
  end

  it 'should return language' do
    country.languages[0].should == 'en'
  end

  describe 'e164' do
    it 'should return country_code' do
      country.country_code.should == '1'
    end

    it 'should return national_destination_code_lengths' do
      country.national_destination_code_lengths.should == [3]
    end

    it 'should return national_number_lengths' do
      country.national_number_lengths.should == [10]
    end

    it 'should return international_prefix' do
      country.international_prefix.should == '011'
    end

    it 'should return national_prefix' do
      country.national_prefix.should == '1'
    end
  end

  describe 'subdivisions' do
    it 'should return an empty hash for a country with no ISO3166-2' do
      ISO3166::Country.search('VA').subdivisions.should have(0).subdivisions
    end

    it 'should return a hash with all sub divisions' do
      country.subdivisions.should have(60).states
    end

    it 'should be available through states' do
      country.states.should have(60).states
    end
  end

  describe 'valid?' do
    it 'should return true if country is valid' do
      ISO3166::Country.new('US').should be_valid
    end

    it 'should return false if country is invalid' do
      ISO3166::Country.new({}).should_not be_valid
    end
  end

  describe 'new' do
    it 'should return new country object when a valid alpha2 string is passed' do
      ISO3166::Country.new('US').should be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 string is passed' do
      ISO3166::Country.new('fubar').should be_nil
    end

    it 'should return new country object when a valid alpha2 symbol is passed' do
      ISO3166::Country.new(:us).should be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 symbol is passed' do
      ISO3166::Country.new(:fubar).should be_nil
    end
  end

  describe 'all' do
    it 'should return an arry list of all countries' do
      countries = ISO3166::Country.all
      countries.should be_an(Array)
      countries.first.should be_an(Array)
      countries.should have(250).countries
    end

    it "should allow to customize each country representation passing a block to the method" do
      countries = ISO3166::Country.all { |country, data| [data['name'], country, data['country_code'] ] }
      countries.should be_an(Array)
      countries.first.should be_an(Array)
      countries.first.should have(3).fields
      countries.should have(250).countries
    end
  end

  describe 'countries' do
    it 'should be the same as all' do
      ISO3166::Country.countries.should == ISO3166::Country.all
    end
  end

  describe 'search' do
    it 'should return new country object when a valid alpha2 string is passed' do
      ISO3166::Country.search('US').should be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 string is passed' do
      ISO3166::Country.search('fubar').should be_nil
    end

    it 'should return new country object when a valid alpha2 symbol is passed' do
      ISO3166::Country.search(:us).should be_a(ISO3166::Country)
    end

    it 'should return nil when an invalid alpha2 symbol is passed' do
      ISO3166::Country.search(:fubar).should be_nil
    end
  end

  describe 'currency' do
    it 'should return an instance of Currency' do
      country.currency.should be_a(ISO4217::Currency)
    end

    it 'should allow access to symbol' do
      country.currency[:symbol].should == '$'
    end
  end

  describe "Country class" do
    context "when loaded via 'iso3166' existance" do
      subject { defined?(Country) }

      it { should be_false }
    end

    context "when loaded via 'countries'" do
      before { require 'countries' }

      describe "existance" do
        subject { defined?(Country) }

        it { should be_true }
      end

      describe "superclass" do
        subject { Country.superclass }

        it { should == ISO3166::Country }
      end

      describe 'to_s' do
        it 'should return the country name' do
          Country.new('GB').to_s.should == 'United Kingdom'
        end
      end
    end
  end

  describe 'find_all_by' do
    context "when searchead attribute equals the given value" do
      let(:spain_data) { ISO3166::Country.find_all_by('alpha2', "ES") }

      it "returns a hash with the data of the country" do
        spain_data.should be_a Hash
        spain_data.should have(1).keys
      end
    end

    context "when searchead attribute is list and one of its elements equals the given value" do
      let(:spain_data) { ISO3166::Country.find_all_by('languages', "en") }

      it "returns a hash with the data of the country" do
        spain_data.should be_a Hash
        spain_data.size.should > 1
      end
    end

    it "also finds results if the given values is not upcased/downcased properly" do
      spain_data = ISO3166::Country.find_all_by('alpha2', "es")
      spain_data.should be_a Hash
      spain_data.should have(1).keys
    end

    it "also finds results if the attribute is given as a symbol" do
      spain_data = ISO3166::Country.find_all_by(:alpha2, "ES")
      spain_data.should be_a Hash
      spain_data.should have(1).keys
    end

    it "casts the given value to a string to perform the search" do
      spain_data = ISO3166::Country.find_all_by(:country_code, 34)
      spain_data.should be_a Hash
      spain_data.keys.should == ['ES']
    end

    it "also performs searches with regexps and forces it to ignore case" do
      spain_data = ISO3166::Country.find_all_by(:names, /Españ/)
      spain_data.should be_a Hash
      spain_data.keys.should == ['ES']
    end
  end

  describe "hash finder methods" do
    context "when search name in 'name'" do
      subject { ISO3166::Country.find_by_name("Poland") }

      its(:first) { should == "PL" }
    end

    context "when search lowercase name in 'name'" do
      subject { ISO3166::Country.find_by_name("poland") }

      its(:first) { should == "PL" }
    end

    context "when search name in 'names'" do
      subject { ISO3166::Country.find_by_name("Polonia") }

      its(:first) { should == "PL" }
    end

    context "when finding by invalid attribute" do
      it "should raise an error" do
        lambda { ISO3166::Country.find_by_invalid('invalid') }.should raise_error
      end
    end

    context "when using find_all method" do
      let(:list) { ISO3166::Country.find_all_by_currency('USD') }

      it "should be an Array of Arrays" do
        list.should be_a(Array)
        list.first.should be_a(Array)
      end
    end

    context "when using find_by method" do
      subject { ISO3166::Country.find_by_alpha3('CAN') }

      its(:length) { should == 2 }
      its(:first) { should be_a(String) }
      its(:last) { should be_a(Hash) }
    end
  end

  describe "country finder methods" do
    context "when search name found" do
      let(:uk) { ISO3166::Country.find_country_by_name("United Kingdom") }

      it "should be a country instance" do
        uk.should be_a(ISO3166::Country)
        uk.alpha2.should == "GB"
      end
    end

    context "when search lowercase name found" do
      let(:uk) { ISO3166::Country.find_country_by_name("united kingdom") }

      it "should be a country instance" do
        uk.should be_a(ISO3166::Country)
        uk.alpha2.should == "GB"
      end
    end

    context "when search name not found" do
      let(:bogus) { ISO3166::Country.find_country_by_name("Does not exist") }

      it "should be a country instance" do
        bogus.should == nil
      end
    end

    context "when finding by invalid attribute" do
      it "should raise an error" do
        lambda { ISO3166::Country.find_country_by_invalid('invalid') }.should raise_error
      end
    end

    context "when using find_all method" do
      let(:list) { ISO3166::Country.find_all_countries_by_currency('USD') }

      it "should be an Array of Country objects" do
        list.should be_a(Array)
        list.first.should be_a(ISO3166::Country)
      end
    end

    context "when using find_by method" do
      let(:country) { ISO3166::Country.find_country_by_alpha3('CAN') }

      it 'should be a single country object' do
        country.should be_a(ISO3166::Country)
      end
    end
  end

  describe "names in Data" do
    it "should be unique (to allow .find_by_name work properly)" do
      names = ISO3166::Country::Data.collect do |k,v|
        [v["name"], v["names"]].flatten.uniq
      end.flatten

      names.size.should == names.uniq.size
    end
  end

  describe 'Norway' do
    let(:norway) { ISO3166::Country.search('NO') }

    it 'should have a currency' do
      norway.currency.should be_a(ISO4217::Currency)
    end
  end

  describe 'Languages' do
    let(:german_speaking_countries) { ISO3166::Country.find_all_countries_by_languages('de') }

    it "should find countries by language" do
      german_speaking_countries.size.should == 6
    end
  end

  describe 'in_eu?' do
    let(:netherlands) { ISO3166::Country.search('NL') }

    it 'should return false for countries without eu_member flag' do
      country.in_eu?.should be_false
    end

    it 'should return true for countries with eu_member flag set to true' do
      netherlands.in_eu?.should be_true
    end
  end

  describe 'to_s' do
    it 'should return the country name' do
      ISO3166::Country.new('GB').to_s.should == 'United Kingdom'
    end
  end

end
