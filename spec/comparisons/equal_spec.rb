Eugeneral.require_sub_module('comparisons')

describe Eugeneral::Comparisons::Equal do
  let(:subject) { double(:subject) }
  let(:object) { double(:object) }
  let(:comparator) { described_class.new(subject, object) }

  before do
    allow(subject).to receive(:resolve).and_return(expected_value)
    allow(object).to receive(:resolve).and_return(actual_value)
  end

  context 'When subject and object values are equal' do
    let(:actual_value) { :foo }
    let(:expected_value) { :foo }

    it 'resolves to true' do
      expect(comparator.resolve('anything')).to eq(true)
    end
  end

  context 'When subject and object values are not equal' do
    let(:actual_value) { :foo }
    let(:expected_value) { :bar }

    it 'resolves to true' do
      expect(comparator.resolve('anything')).to eq(false)
    end
  end
end
