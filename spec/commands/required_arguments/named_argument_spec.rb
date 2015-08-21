require_relative '../../../lib/eugeneral/commands/required_arguments/arguments'

describe Eugeneral::RequiredArguments::NamedArgument do
  context 'Given a NamedArgument' do
    subject(:named_argument) { described_class.new(name) }

    context 'with a symbolized name' do
      let(:name) { :foo }

      context 'when resolved with a hash containing symbol foo' do

        it 'finds bar' do
          expect(subject.resolve(foo: 'bar')).to eq('bar')
        end
      end

      context 'when resolved with a hash containing string foo' do

        it 'finds bar' do
          expect(subject.resolve('foo' => 'bar')).to eq('bar')
        end
      end

      context 'when resolved with a hash not containing its name' do

        it 'throws an error' do
          expect {
            subject.resolve(fruit: 'apple', color: 'green')
          }.to raise_error('Missing argument: foo')
        end
      end
    end

    context 'with a string name' do
      let(:name) { 'foo' }

      context 'when resolved with a hash containing symbol foo' do

        it 'finds bar' do
          expect(subject.resolve(foo: 'bar')).to eq('bar')
        end
      end

      context 'when resolved with a hash containing string foo' do

        it 'finds bar' do
          expect(subject.resolve('foo' => 'bar')).to eq('bar')
        end
      end

      context 'when resolved with a hash not containing its name' do

        it 'throws an error' do
          expect {
            subject.resolve(fruit: 'apple', color: 'green')
          }.to raise_error('Missing argument: foo')
        end
      end
    end

  end
end
