# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Maxmind::City do

  let(:toronto) { Maxmind::City.cities_in_country('CA')['toronto'] }
  let(:place) { Maxmind::City.cities_in_country('TJ')["22 (dvadtsat' vtorogo) parts''yezd"] }

  it 'should be a City' do
    toronto.should be_a Maxmind::City
    place.should be_a Maxmind::City
  end

  it 'should have name' do
    toronto.name.should eql 'Toronto'
    place.name.should eql "22 (Dvadtsat' Vtorogo) Parts''yezd"
  end

  it 'should have latitude' do
    toronto.latitude.should be_a Float
  end

  it 'should have longitude' do
    toronto.longitude.should be_a Float
  end

  it 'should have latlong' do
    toronto.latlong.should be_an Array
  end

  it 'should have population' do
    toronto.population.should be_an Integer
    place.population.should be_nil
  end

  it 'should have region' do
    toronto.region.should be_a String
  end

  describe 'cities_in_country' do

    let(:cities) { Maxmind::City.cities_in_country('US') }

    it 'returns hash' do
      cities.should be_a Hash
      cities.keys.should include 'seattle'
      cities['seattle'].should be_a Maxmind::City
    end

  end

  describe 'cities_in_country?' do
    
    it 'returns true for country with cities file' do
      Maxmind::City.cities_in_country?('US').should be_true
    end

    it 'returns false otherwise' do
      Maxmind::City.cities_in_country?('XX').should be_false
    end

  end

  describe 'path_for_country' do

    let(:path) { Maxmind::City.path_for_country('US') }

    it 'returns string' do
      path.should match /\/data\/cities\/US\.yaml/
    end

  end

end
