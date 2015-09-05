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

      it 'will call the proc with the given arguments' do
        expect(proc).to receive(:call).with('foo', 'bar')
        general.foo('foo', 'bar')
      end
    end
  end
end