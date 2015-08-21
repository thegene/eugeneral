require_relative '../../../lib/eugeneral/commands/arguments_with_default/arguments'

describe Eugeneral::ArgumentsWithDefault::PositionalArgument do
  context 'Given a PositionalArgument' do
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
  end
end