require_relative '../../../lib/eugeneral/commands/logic/logic'

describe Eugeneral::Logic::And do
  context 'Given an And expression' do
    let(:subject) { described_class.new(expressions) }

    context 'instantiated with no expressions' do
      let(:expressions) { [] }

      it 'resolves to true' do
        expect(subject.resolve).to be(true)
      end

    end

    context 'instantiated with one expression' do
      context 'which is a command' do
        let(:expressions) { [ double(:expression) ] }

        before do
          allow(expressions.first).to receive(:resolve).and_return(value)
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
        let(:expressions) { [ value ] }

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
      context 'which are commands' do
        let(:expressions) { [ double(:expression), double(:expression) ] }

        before do
          allow(expressions.first).to receive(:resolve).and_return(first_value)
          allow(expressions.last).to receive(:resolve).and_return(second_value)
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

        let(:expressions) { [ first_value, second_value ] }

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
    end

    context 'when resolving with arguments' do
      let(:args) { [ {a: 'b'}, ['one', 2] ] }

      context 'when expressions are commands' do
        let(:expressions) { [ double(:expression) ] }

        before do
          allow(expressions.first).to receive(:resolve)
        end

        it 'resolves its expressions with arguments' do
          expect(expressions.first).to receive(:resolve).with(args)
          subject.resolve(args)
        end
      end
    end

  end
end