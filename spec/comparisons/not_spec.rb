Eugeneral.require_sub_module('comparisons')

describe Eugeneral::Comparisons::Not do
  context 'Given a Not comparison' do
    let(:subject) { described_class.new(command) }
    let(:command) { double(:command) }
    let(:args) { { foo: 'bar', a: 'b' } }


    before do
      allow(command).to receive(:resolve).with(args).and_return(resolution)
    end

    context 'with a command resolving to true' do
      let(:resolution) { true }

      it 'will resolve to false' do
        expect(subject.resolve(args)).to be(false)
      end
    end

    context 'with a command resolving to false' do
      let(:resolution) { false }

      it 'will resolve to true' do
        expect(subject.resolve(args)).to be(true)
      end
    end
  end
end