describe 'timezone Country class' do
  context "when loaded via 'timezone'" do
    require 'countries/timezones'
    describe 'existance' do
      subject { defined?(TZInfo) }

      it { is_expected.to be_truthy }
    end

    describe 'GB' do
      subject { Country.new('GB') }
      it 'should return the tzinfo country object' do
        expect(subject.timezones).to be_a(TZInfo::Country)
      end

      it 'should return the tzinfo country object' do
        expect(subject.timezones.zone_info).to be_a(Array)
      end

      it 'should return the tzinfo country object' do
        expect(subject.timezones.zone_identifiers).to eq ['Europe/London']
      end
    end

    describe 'US' do
      subject { Country.new('US') }
      it 'should return the tzinfo country object' do
        expect(subject.timezones.zone_identifiers.size).to eq 29
      end
    end
  end
end
