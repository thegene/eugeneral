require_relative '../lib/eugeneral/general'

describe Eugeneral::General do
  context 'Given a General' do
    subject(:general) { described_class.new }

    it 'is not initially useful' do
      expect{ general.foo }.to raise_error(NoMethodError)
    end

    context 'when assigned a command' do
      let(:proc) { double(:proc) }

      before do
        general.command(:foo, proc)
      end

      context 'when called with no arguments' do
        before do
          expect(proc).to receive(:call).with(no_args)
        end

        it 'will call the proc with no arguments' do
          general.foo
        end

      end

      context 'when called with positional arguments' do
        before do
          expect(proc).to receive(:call).with( ['foo', 'bar'] )
        end

        it 'will call the proc with the given arguments as an array' do
          general.foo('foo', 'bar')
        end
      end

      context 'when called with named arguments' do
        before do
          expect(proc).to receive(:call).with( {foo: 'bar'} )
        end

        it 'will call the proc with a hash' do
          general.foo(foo: 'bar')
        end
      end

      context 'when called with both positional and named' do
        before do
          expect(proc).to receive(:call).with( ['foo', 'bar', { foo: 'bar' }] )
        end

        it 'will call the proc with an array containing both' do
          general.foo('foo', 'bar', foo: 'bar')
        end
      end

    end
  end
end