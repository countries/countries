describe 'global Country class', order: :defined do
  context "when loaded via 'iso3166' existence" do
    subject { defined?(Country) }

    it { is_expected.to be_falsey }
  end

  context "when loaded via 'global'" do
    before { require 'countries/global' }

    describe 'existence' do
      subject { defined?(Country) }

      it { is_expected.to be_truthy }
    end

    describe 'superclass' do
      subject { Country.superclass }

      it { is_expected.to eq(ISO3166::Country) }
    end

    describe 'to_s' do
      it 'should return the country name' do
        expect(Country.new('GB').to_s).to eq('United Kingdom of Great Britain and Northern Ireland')
      end
    end
  end
end
