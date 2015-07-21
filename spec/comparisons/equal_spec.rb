require_relative '../../lib/eugeneral/comparisons/comparisons'

describe Eugeneral::Comparisons::Equal do
  context 'Given an Equal Comparitor' do
    let(:comparator) { described_class.new(subject, object) }

    context 'instantiated with commands' do
      let(:subject) { double(:subject) }
      let(:object) { double(:object) }

      before do
        allow(subject).to receive(:resolve).and_return(subject_value)
        allow(object).to receive(:resolve).and_return(object_value)
      end

      context 'When subject and object values are equal' do
        let(:object_value) { :foo }
        let(:subject_value) { :foo }

        it 'resolves to true' do
          expect(comparator.resolve('anything')).to eq(true)
        end
      end

      context 'When subject and object values are not equal' do
        let(:object_value) { :foo }
        let(:subject_value) { :bar }

        it 'resolves to true' do
          expect(comparator.resolve('anything')).to eq(false)
        end
      end
    end

    context 'instantiated with values' do

      context 'When subject and object values are equal' do
        let(:object) { :foo }
        let(:subject) { :foo }

        it 'resolves to true' do
          expect(comparator.resolve('anything')).to eq(true)
        end
      end

      context 'When subject and object values are not equal' do
        let(:object) { :foo }
        let(:subject) { :bar }

        it 'resolves to true' do
          expect(comparator.resolve('anything')).to eq(false)
        end
      end
    end
  end
end
