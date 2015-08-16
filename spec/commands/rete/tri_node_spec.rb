require_relative '../../../lib/eugeneral/commands/rete/rete'

describe Eugeneral::Rete::TriNode do
  context 'Given a rete tri node' do
    subject(:node) { described_class.new(nodes) }
    let(:args) { ['foo', 'bar'] }

    context 'with a single sub command' do
      let(:command) { double(:command) }
      let(:nodes) { [command] }
      before do
        allow(command).to receive(:resolve).with(args).and_return('something')
      end

      it 'resolves to the resolved sub command' do
        expect(subject.resolve(args)).to eq('something')
      end

    end

    context 'with two nodes' do
      let(:first) { 'something' }
      let(:second) { double(:second) }

      let(:nodes) { [first, second] }

      before do
        allow(second).to receive(:resolve).and_return(second_value)
      end

      let(:second_value) { 'something else' }

      context 'when the first resolves to something' do

        it 'resolves to something' do
          expect(subject.resolve).to eq('something')
        end

        it 'does not call on the second node' do
          expect(second).not_to receive(:resolve)
          subject.resolve
        end

      end

      context 'when the first resolves to false' do
        let(:first) { false }

        it 'resolves to the value of the second node' do
          expect(subject.resolve).to eq('something else')
        end

      end
    end

    context 'with three nodes' do
      let(:nodes) { [first, second, third] }

      let(:first) { double(:first) }
      let(:second) { double(:second) }
      let(:third) { double(:third) }

      let(:first_value) { nil }
      let(:second_value) { nil }
      let(:third_value) { nil }

      before do
        allow(first).to receive(:resolve).and_return(first_value)
        allow(second).to receive(:resolve).and_return(second_value)
        allow(third).to receive(:resolve).and_return(third_value)
      end

      context 'when the first resolves to something' do
        let(:first_value) { 'something' }

        it 'calls on the first node' do
          expect(first).to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the second node' do
          expect(second).not_to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the third node' do
          expect(third).not_to receive(:resolve)
          subject.resolve
        end
      end

      context 'when the second resolves to something' do
        let(:second_value) { 'something' }

        it 'calls on the first node' do
          expect(first).to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the second node' do
          expect(second).to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the third node' do
          expect(third).not_to receive(:resolve)
          subject.resolve
        end
      end

      context 'when the third resolves to something' do
        let(:third_value) { 'something' }

        it 'calls on the first node' do
          expect(first).to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the second node' do
          expect(second).to receive(:resolve)
          subject.resolve
        end

        it 'does not call on the third node' do
          expect(third).to receive(:resolve)
          subject.resolve
        end
      end
    end
  end
end