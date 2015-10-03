require_relative '../../../lib/eugeneral/commands/logic/logic'

describe Eugeneral::Logic::And do
  context 'Given an And expression' do
    context 'instantiated with no expressions' do

      subject { described_class.new }

      it 'resolves to true' do
        expect(subject.resolve).to be(true)
      end

    end

    context 'instantiated with one expression' do
      subject { described_class.new(expression) }
      let(:expression) { double(:expression) }

      context 'when resolving with arguments' do
        let(:args) { [ {a: 'b'}, ['one', 2] ] }

        context 'when expressions are commands' do
          let(:expression) { double(:expression) }

          before do
            allow(expression).to receive(:resolve)
          end

          it 'resolves its expressions with arguments' do
            expect(expression).to receive(:resolve).with(args)
            subject.resolve(args)
          end
        end
      end

      context 'which is a command' do
        let(:expressions) { expression }

        before do
          allow(expression).to receive(:resolve).and_return(value)
        end

        context 'which resolves to true' do
          let(:value) { true }

          it 'resolves to true' do
            expect(subject.resolve).to be(true)
          end
        end

        context 'which resolves to false' do
          let(:value) { false }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end
      end


      context 'which is a value' do
        let(:expression) { value }

        context 'which resolves to true' do
          let(:value) { true }

          it 'resolves to true' do
            expect(subject.resolve).to be(true)
          end
        end

        context 'which resolves to false' do
          let(:value) { false }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end
      end
    end

    context 'instantiated with two expressions' do
      subject { described_class.new(expression_one, expression_two) }
      let(:expression_one) { double(:expression_one) }
      let(:expression_two) { double(:expression_two) }

      context 'which are commands' do

        before do
          allow(expression_one).to receive(:resolve).and_return(first_value)
          allow(expression_two).to receive(:resolve).and_return(second_value)
        end

        context 'which both return true' do
          let(:first_value) { true }
          let(:second_value) { true }

          it 'resolves to true' do
            expect(subject.resolve).to be(true)
          end
        end

        context 'which both return false' do
          let(:first_value) { false }
          let(:second_value) { false }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end

        context 'which return both false and true' do
          let(:first_value) { false }
          let(:second_value) { true }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end
      end

      context 'which are values' do

        context 'which both return true' do
          let(:expression_one) { true }
          let(:expression_two) { true }

          it 'resolves to true' do
            expect(subject.resolve).to be(true)
          end
        end

        context 'which both return false' do
          let(:expression_one) { false }
          let(:expression_two) { false }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end

        context 'which return both false and true' do
          let(:expression_one) { false }
          let(:expression_two) { true }

          it 'resolves to false' do
            expect(subject.resolve).to be(false)
          end
        end
      end
    end


  end
end