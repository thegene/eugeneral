require_relative '../../../lib/eugeneral/commands/arguments_with_default/arguments'

describe Eugeneral::ArgumentsWithDefault::NamedArgument do
  context 'Given a NamedArgument' do
    subject(:argument) { described_class.new(name, default) }
    let(:default) { ['one', 'two', 'five!'] }

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

        it 'returns the default' do
          expect(subject.resolve('green' => 'apple')).to eq(['one', 'two', 'five!'])
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

        it 'returns the default' do
          expect(subject.resolve('green' => 'apple')).to eq(['one', 'two', 'five!'])
        end
      end
    end
  end
end