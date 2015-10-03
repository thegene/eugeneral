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

      it 'will call the proc with the given arguments as an array' do
        expect(proc).to receive(:call).with( ['foo', 'bar'] )
        general.foo('foo', 'bar')
      end

      it 'will call the proc with a hash' do
        expect(proc).to receive(:call).with( {foo: 'bar'} )
        general.foo(foo: 'bar')
      end

      it 'will call the proc with an array containing both' do
        expect(proc).to receive(:call).with( ['foo', 'bar', { foo: 'bar' }] )
        general.foo('foo', 'bar', foo: 'bar')
      end
    end
  end
end