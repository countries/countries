require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Country do
  before(:all) do
    @country = Country['US']
  end
  
  it 'should return 3166 number' do
    @country.number.should == '840'
  end
  
  it 'should return 3166 alpha2 code' do
    @country.alpha2.should == 'US'
  end
  
  it 'should return 3166 alpha3 code' do
    @country.alpha3.should == 'USA'
  end
  
  it 'should return 3166 name' do
    @country.name.should == 'United States'
  end
  
  it 'should return alternate names' do
    @country.names.should == ["United States of America", "Vereinigte Staaten von Amerika", "États-Unis", "Estados Unidos"]
  end
  
  it 'should return latitude' do
    @country.latitude.should == '38 00 N'
  end
  
  it 'should return longitude' do
    @country.longitude.should == '97 00 W'
  end

  it 'should return region' do
    @country.region.should == 'Americas'
  end

  it 'should return subregion' do
    @country.subregion.should == 'Northern America'
  end
  
  describe 'e164' do
    it 'should return country_code' do
      @country.country_code.should == '1'
    end
    
    it 'should return national_destination_code_lengths' do
      @country.national_destination_code_lengths.should == [3]
    end
    
    it 'should return national_number_lengths' do
      @country.national_number_lengths.should == [10]
    end               
                      
    it 'should return international_prefix' do
      @country.international_prefix.should == '011'
    end               
                      
    it 'should return national_prefix' do
      @country.national_prefix.should == '1'
    end
  end
  
  describe '[]' do
    it 'should return new country object when a alpha2 is passed' do
      Country['US'].should be_a(Country)
    end
  end
end
