# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ISO3166::Country do

  let(:country) { ISO3166::Country.search('US') }

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
    country.names.should == ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]
  end

  it 'should return latitude' do
    country.latitude.should == '38 00 N'
  end

  it 'should return longitude' do
    country.longitude.should == '97 00 W'
  end

  it 'should return region' do
    country.region.should == 'Americas'
  end

  it 'should return subregion' do
    country.subregion.should == 'Northern America'
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
      country.subdivisions.should have(57).states
    end

    it 'should be available through states' do
      country.states.should have(57).states
    end
  end

  describe 'cities' do
  
    it 'should return correct hash of hashed cities' do
      ISO3166::Country.search('WF').cities.should have(39).cities
    end

    it 'should return empty hash for country with no cities' do
      ISO3166::Country.search('VA').cities.should have(0).cities
    end

  end
  
  describe 'valid?' do
    it 'should return true if country is valid' do
      ISO3166::Country.new('US').should be_valid
    end

    it 'should return false if country is invalid' do
      ISO3166::Country.new('fubar').should_not be_valid
    end
  end
  
  describe 'all' do
    it 'should return an arry list of all countries' do
      countries = ISO3166::Country.all
      countries.should be_an(Array)
      countries.first.should be_an(Array)
      countries.should have(246).countries
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

    it 'should return fals when an invalid alpha2 string is passed' do
      ISO3166::Country.search('fubar').should be_false
    end

    it 'should return new country object when a valid alpha2 symbol is passed' do
      ISO3166::Country.search(:us).should be_a(ISO3166::Country)
    end

    it 'should return false when an invalid alpha2 symbol is passed' do
      ISO3166::Country.search(:fubar).should be_false
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
    end
  end

  describe ".find_by_name" do
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
  end

  describe ".find_country_by_name" do
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

end
