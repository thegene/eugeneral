Eugeneral.require_sub_module('comparisons')

describe Eugeneral::Comparisons::Not do
  context 'Given a Not comparison' do
    context 'when instantiated with commands' do
      let(:subject) { described_class.new(command) }
      let(:command) { double(:command) }

      context 'when resolved with arguments' do
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

      context 'when resolved without arguments' do
        before do
          allow(command).to receive(:resolve).and_return(resolution)
        end

        context 'with a command resolving to true' do
          let(:resolution) { true }

          it 'will resolve to false' do
            expect(subject.resolve).to be(false)
          end
        end

        context 'with a command resolving to false' do
          let(:resolution) { false }

          it 'will resolve to true' do
            expect(subject.resolve).to be(true)
          end
        end
      end
    end
  end

  context 'when instantiated with a value' do
    let(:subject) { described_class.new(value) }

    context 'when resolved with arguments' do
      let(:args) { { foo: 'bar', a: 'b' } }

      context 'with a command resolving to true' do
        let(:value) { true }

        it 'will resolve to false' do
          expect(subject.resolve(args)).to be(false)
        end
      end

      context 'with a command resolving to false' do
        let(:value) { false }

        it 'will resolve to true' do
          expect(subject.resolve(args)).to be(true)
        end
      end
    end

    context 'when resolved without arguments' do

      context 'with a command resolving to true' do
        let(:value) { true }

        it 'will resolve to false' do
          expect(subject.resolve).to be(false)
        end
      end

      context 'with a command resolving to false' do
        let(:value) { false }

        it 'will resolve to true' do
          expect(subject.resolve).to be(true)
        end
      end
    end
  end
end