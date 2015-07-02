Eugeneral.require_sub_module('comparisons')

describe Eugeneral::Comparisons::Equal do
  let(:expected) { double(:expected) }
  let(:actual) { double(:actual) }
  let(:subject) { described_class.new(expected, actual) }

  before do
    allow(expected).to receive(:resolve).and_return(expected_value)
    allow(actual).to receive(:resolve).and_return(actual_value)
  end

  context 'When expected and actual values are equal' do
    let(:actual_value) { :foo }
    let(:expected_value) { :foo }

    it 'resolves to true' do
      expect(subject.resolve('anything')).to eq(true)
    end
  end

  context 'When expected and actual values are not equal' do
    let(:actual_value) { :foo }
    let(:expected_value) { :bar }

    it 'resolves to true' do
      expect(subject.resolve('anything')).to eq(false)
    end
  end
end
