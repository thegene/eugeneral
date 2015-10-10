require_relative '../../../lib/eugeneral/commands/arguments/arguments'

describe Eugeneral::Arguments::PositionalWithDefault do
  context 'Given a PositionalWithDefault' do
    subject(:argument) { described_class.new(position, default) }
    let(:position) { 1 }
    let(:default) { '5?' }

    context 'when passed an array without a value at this position' do
      let(:array) { ['wrong thing'] }

      it 'returns the default' do
        expect(subject.resolve(array)).to eq('5?')
      end
    end

    context 'when passed an array with a value at this position' do
      let(:array) { ['wrong thing', 'correct thing'] }

      it 'returns the correct thing' do
        expect(subject.resolve(array)).to eq('correct thing')
      end
    end

    context 'when passed an array with a false value at this position' do
      let(:array) { [true, false] }

      it 'returns the false, not the default value' do
        expect(subject.resolve(array)).to eq(false)
      end
    end

    context 'when passed an array with a nil value at this position' do
      let(:array) { [true, nil] }

      it 'returns the nil, not the default value' do
        expect(subject.resolve(array)).to eq(nil)
      end
    end
  end
end