require_relative '../../../lib/eugeneral/commands/comparisons/comparisons'

describe Eugeneral::Comparisons::GreaterThan do
  context 'Given a comparison of GreaterThan' do
    let(:comparator) { described_class.new(subject, object) }

    context 'when instantiated with commands' do
      let(:subject) { double(:subject) }
      let(:object) { double(:object) }

      context 'when resolved with args' do
        let(:args) { ['foo', 'bar'] }

        before do
          allow(subject).to receive(:resolve).with(args).and_return(subject_value)
          allow(object).to receive(:resolve).with(args).and_return(object_value)
        end

        context 'when subject is greater than object' do
          let(:subject_value) { 2 }
          let(:object_value) { 1 }

          it 'resolves to true' do
            expect(comparator.resolve(args)).to eq(true)
          end
        end

        context 'subject is less than object' do
          let(:subject_value) { 1 }
          let(:object_value) { 2 }

          it 'resolves to false' do
            expect(comparator.resolve(args)).to eq(false)
          end
        end

        context 'when subject is equal to object' do
          let(:subject_value) { 1 }
          let(:object_value) { 1 }

          it 'resolves to false' do
            expect(comparator.resolve(args)).to eq(false)
          end
        end
      end
      context 'when resolved without args' do

        before do
          allow(subject).to receive(:resolve).and_return(subject_value)
          allow(object).to receive(:resolve).and_return(object_value)
        end

        context 'when subject is greater than object' do
          let(:subject_value) { 2 }
          let(:object_value) { 1 }

          it 'resolves to true' do
            expect(comparator.resolve).to eq(true)
          end
        end

        context 'subject is less than object' do
          let(:subject_value) { 1 }
          let(:object_value) { 2 }

          it 'resolves to false' do
            expect(comparator.resolve).to eq(false)
          end
        end

        context 'when subject is equal to object' do
          let(:subject_value) { 1 }
          let(:object_value) { 1 }

          it 'resolves to false' do
            expect(comparator.resolve).to eq(false)
          end
        end
      end
    end

    context 'when instantiated with values' do
      context 'when resolved with args' do
        let(:args) { ['foo', 'bar'] }

        context 'when subject is greater than object' do
          let(:subject) { 2 }
          let(:object) { 1 }

          it 'resolves to true' do
            expect(comparator.resolve(args)).to eq(true)
          end
        end

        context 'subject is less than object' do
          let(:subject) { 1 }
          let(:object) { 2 }

          it 'resolves to false' do
            expect(comparator.resolve(args)).to eq(false)
          end
        end

        context 'when subject is equal to object' do
          let(:subject) { 1 }
          let(:object) { 1 }

          it 'resolves to false' do
            expect(comparator.resolve(args)).to eq(false)
          end
        end
      end
      context 'when resolved without args' do

        context 'when subject is greater than object' do
          let(:subject) { 2 }
          let(:object) { 1 }

          it 'resolves to true' do
            expect(comparator.resolve).to eq(true)
          end
        end

        context 'subject is less than object' do
          let(:subject) { 1 }
          let(:object) { 2 }

          it 'resolves to false' do
            expect(comparator.resolve).to eq(false)
          end
        end

        context 'when subject is equal to object' do
          let(:subject) { 1 }
          let(:object) { 1 }

          it 'resolves to false' do
            expect(comparator.resolve).to eq(false)
          end
        end
      end
    end
  end
end