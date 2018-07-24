describe 'global Country class', order: :defined do
  context "when loaded via 'iso3166' existence" do
    subject { defined?(Country) }

    it { is_expected.to be_falsey }
  end

  context "when loaded via 'global'" do
    before { require 'countries/global' }

    it 'does not pollute global namespace with Money gem' do
      expect(defined?(Money)).not_to be
      expect(ISO3166::Country.new('DE').respond_to?(:currency)).not_to be
    end

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

    describe 'currency' do
      it { expect(Country.new('GB').respond_to?(:currency)).not_to be }

      context 'I enable currency extension via config' do
        before { ISO3166.configuration.enable_currency_extension! }

        it 'should add currency to global country' do
          expect(Country.new('GB').currency).to be
        end
      end
    end

    context 'I enable currency extension via config' do
      before { ISO3166.configuration.enable_currency_extension! }

      it 'should add currency to global country' do
        expect(Country.new('GB').currency).to be
        expect(defined?(Money)).to be
        expect(ISO3166::Country.new('DE').currency).to be
      end
    end
  end
end
