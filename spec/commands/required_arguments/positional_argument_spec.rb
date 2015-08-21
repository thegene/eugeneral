require_relative '../../../lib/eugeneral/commands/required_arguments/arguments'

describe Eugeneral::RequiredArguments::PositionalArgument do
  context 'Given a PositionalArgument' do
    subject(:argument) { described_class.new(position) }
    let(:position) { 1 }

    context 'when passed an array without a value at this position' do
      let(:array) { ['wrong thing'] }

      it 'raises an error' do
        expect {
          subject.resolve(array)
        }.to raise_error('Missing argument: 1')
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