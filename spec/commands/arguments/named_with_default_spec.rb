require_relative '../../../lib/eugeneral/commands/arguments/arguments'

describe Eugeneral::Arguments::NamedWithDefault do
  context 'Given a NamedWithDefault' do
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

      context 'when the named argument is false' do

        it 'returns false rather than the default' do
          expect(subject.resolve(foo: false)).to be(false)
        end
      end

      context 'when the named argument is nil' do

        it 'returns nil rather than the default' do
          expect(subject.resolve(foo: nil)).to be(nil)
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