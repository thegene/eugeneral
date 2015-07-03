Eugeneral.require_sub_module('comparisons')

describe Eugeneral::Comparisons::GreaterThan do
  context 'Given a comparison of GreaterThan' do
    let(:subject) { double(:subject) }
    let(:object) { double(:object) }
    let(:comparator) { described_class.new(subject, object) }
    let(:args) { ['foo', 'bar'] }

    before do
      allow(subject).to receive(:resolve).with(*args).and_return(subject_value)
      allow(object).to receive(:resolve).with(*args).and_return(object_value)
    end

    context 'when subject is greater than object' do
      let(:subject_value) { 2 }
      let(:object_value) { 1 }

      it 'resolves to true' do
        expect(comparator.resolve(*args)).to eq(true)
      end
    end

    context 'subject is less than object' do
      let(:subject_value) { 1 }
      let(:object_value) { 2 }

      it 'resolves to false' do
        expect(comparator.resolve(*args)).to eq(false)
      end
    end

    context 'when subject is equal to object' do
      let(:subject_value) { 1 }
      let(:object_value) { 1 }

      it 'resolves to false' do
        expect(comparator.resolve(*args)).to eq(false)
      end
    end
  end
end